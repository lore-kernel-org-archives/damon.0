Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA99B37E5C2
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 05:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788240294; cv=none; b=lRSPRfcjiC7UjthRLR251drW9uoc5yRU1BCLVOa1CHmng99Qp4hBs01OFEdvdbEcxuXg7McYX7ST7JtuKEe/2oH1bKr8vbbboXnYZdnFLNEFGTGO15SIasD//FNmJcdj4KoA7Z78zC1sUEzS/67zNiqVwNDhJ0EaQE+ZGJr5qpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788240294; c=relaxed/simple;
	bh=AjFpDQH04QGhhEU4DYYHqdOqekbBChrM43hX314Hnv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLSFT3NObsL3igZGB3/ROHc4VLhxNihOe6+YzT/PpjLcg3c52FleLPXUHotIxy884A0G3aLyW3sE8dkIkY0bV9D2zzHniz9539I9mb6b9sJ9juYiF7PVDL1a22HM8InEXLTqesml7G/PIhe67QzMy1hr31wDq//DU5lKctEnUp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVNVB2if; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVNVB2if"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423331F000E9;
	Tue,  1 Sep 2026 05:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788240293;
	bh=N1Qef8p6H5tPefGA87iHYtftZppHaVJg2EVht5kxbPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AVNVB2ifmTwEqHfxZz+A3FX3OjufZNgx4qnm5CKl3LJj/JDqBUFMnmRW62+uzT2u+
	 cQgDn9423OLOqmba2S2XCU4UmGZQm6sCKNiqsKt/NVkz7bFc1etADNduhmi4UqtadX
	 DSyOBIMPNOi61FE9pvFtORqwPiylm+HAJlQC+KeOSGr+sWddKjjrnlKaXkafE5vC1F
	 kmftWra2Wc1RAGgAk2+QvZKKeW8YPvgbB6YRdDTCzXYBb3j5FAstlgT2zzIGpec7NV
	 cEpG76KqlqipgNE01eHcwUStt1YbnrVe2ehO27vvojtMTKdnxn9Lk2IcRNEkJQgWxP
	 OwejYHO4DKp1w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 13/17] mm/damon/sysfs: pass preps to DAMON core
Date: Mon, 31 Aug 2026 22:24:44 -0700
Message-ID: <20260901052446.4122-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901045314.9C8631F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 04:53:14 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Data race on `sys_prep->action` due to lockless read and write
> --
> 
> commit 09b46cd761363fb28603bd1d27adb637a6c16a7d
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: pass preps to DAMON core
>     
> DAMON sysfs interface provides the files for setting DAMON probe preps.
> But the underlying code is not really passing the user-set values to
> DAMON core.  Pass those.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index c0130843223d7..d02f5f8ceae5b 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -2176,6 +2176,23 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
> >  	return damon_set_attrs(ctx, &attrs);
> >  }
> >  
> > +static int damon_sysfs_set_preps(struct damon_probe *probe,
> > +		struct damon_sysfs_preps *sys_preps)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < sys_preps->nr; i++) {
> > +		struct damon_sysfs_prep *sys_prep = sys_preps->preps_arr[i];
> > +		struct damon_prep *prep;
> > +
> > +		prep = damon_new_prep(sys_prep->action);
> 
> [Severity: Low]
> Could this result in a data race on sys_prep->action?
> 
> During DAMON context building, this locklessly reads the action enum while a
> concurrent root user could be writing to the /sys/.../prep_action attribute.
> 
> A concurrent write to prep_action could happen while another process issues a
> commit command to the state file, which runs damon_sysfs_commit_input
> asynchronously on the kdamond thread without holding damon_sysfs_lock.
> 
> Would it be better to use READ_ONCE() here, along with a corresponding
> WRITE_ONCE() on the writer side, to adhere to the Linux Kernel Memory Model
> guidelines and avoid potential KCSAN warnings?

Good catch.  A few similar call paths protect stores with damon_sysfs_lock.  I
will protect prep->action writing with the lock.  Because the context build is
done while holding the lock, it should avoid the race, like below.

'''
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -827,7 +827,10 @@ static ssize_t prep_action_store(struct kobject *kobj,

                action_name = &damon_sysfs_prep_action_names[i];
                if (sysfs_streq(buf, action_name->name)) {
+                       if (!mutex_trylock(&damon_sysfs_lock))
+                               return -EBUSY;
                        prep->action = action_name->action;
+                       mutex_unlock(&damon_sysfs_lock);
                        ret = count;
                        break;
                }
'''

> 
> > +		if (!prep)
> > +			return -ENOMEM;
> > +		damon_add_prep(probe, prep);
> > +	}
> > +	return 0;
> > +}
> > +
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260901043417.2165-1-sj@kernel.org?part=13


Thanks,
SJ
