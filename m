Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F89305693
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238920; cv=none; b=HSqTgU2CB1rrdhB1G6HnUKSSSb/88m62XnqowdtMcNkPlmpGoQGIG/nfkcI8m8xdLF/sXNE+OcD3f5/FOQ4uUYrhl7Qx1nR7LDV80oITTX5FkqPM+AJobC9jGeL4UCA07/2XNM5c3bPamCB2Q7DvxkphWXKMfQtVJjJAQtndLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238920; c=relaxed/simple;
	bh=vOW+sM+D8qh9dqmWyAfvoUKH9PH/zVQJopskjMwAu08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGDqPalXcLRxRkv/RIMNYxLOHA75Ftbmha9oaggcTEHlEdBzx5ArDiQ1X707NpBiz4A0kWOnNis2GHw7vpHQ6rmvGncPh3yygFaFu6n935Bd10k0eH5RT+ojdtDI1sKM9sBhrhIsX5GpDO1gPUpOdcba8T7/drk0ChXWixP+ebc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnVIvTc5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnVIvTc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABC61F000E9;
	Tue,  1 Sep 2026 05:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788238919;
	bh=iCGdlz5ER+cIyhKOAbJyT6wCt9fkWTKkk/2tgNkHj+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QnVIvTc5tgHgflSgHYc81MttL6PO2WqDohByc9cJwn/SC+GHUyFOWf8HW0+A74EhF
	 ViiXOUVid1E4kPrt2vrVMNx4xOLeibANjwxC6mRV/59WnxlrSo5IvdAVtV6nmtlRU6
	 kJoOKhpu7ohstpeU6AgqW+n6YP9MeMhUYOSUETxIdcWHPusQfUH4KfNommX83H527J
	 rSmE2WnQpqUeuFAkhpx+zPaOPhxWBU7WfZWj0PxKIwTxL6vxrpArHEsPthY7s7c6ex
	 58TMiRVg5gxvMhnOJoBF47uH0XrScDRthtn5atKf//wD8tnijQTTkyfRlpcGEW1HNW
	 bgmN1RBK0LktQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 05/17] mm/damon/core: introduce damon_prep struct
Date: Mon, 31 Aug 2026 22:01:49 -0700
Message-ID: <20260901050151.3659-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901044601.B5FCA1F00A3D@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 04:46:01 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing exported cleanup API for `struct damon_prep` leads to broken abstraction on error paths.
> --
> 
> commit 046989ba790c1b12be9fe4a07f46c502a62eeb7b
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_prep struct
> 
> This commit introduces the damon_prep data structure to specify preparatory
> actions for DAMON probes. It also adds DAMON_PREP_SET_PGIDLE as the initial
> preparation action for access monitoring.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 644daf5a16560..0b396c2456d05 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -111,6 +111,28 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
> >  	return err;
> >  }
> >  
> > +struct damon_prep *damon_new_prep(enum damon_prep_action action)
> > +{
> > +	struct damon_prep *prep;
> > +
> > +	prep = kmalloc_obj(*prep);
> > +	if (!prep)
> > +		return NULL;
> > +	prep->action = action;
> > +	INIT_LIST_HEAD(&prep->list);
> > +	return prep;
> > +}
> 
> [Severity: Low]
> Is there a missing exported cleanup API for struct damon_prep?
> 
> Since damon_new_prep() is exposed for external modules to allocate a new
> prep structure, do they need a corresponding exported destructor (like
> damon_destroy_prep()) to clean it up if an error occurs before it is
> attached to a probe via damon_add_prep()?
> 
> Currently, damon_free_prep() is static, which forces any external caller to
> manually call kfree() on error paths, potentially breaking the subsystem's
> abstraction.

The cleanup API is not necessary.  Callers will be able to free up preps with
the context at once using damon_destroy_ctx().

> 
> > +
> > +void damon_add_prep(struct damon_probe *p, struct damon_prep *prep)
> > +{
> > +	list_add_tail(&prep->list, &p->preps);
> > +}
> > +
> > +static void damon_free_prep(struct damon_prep *p)
> > +{
> > +	kfree(p);
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260901043417.2165-1-sj@kernel.org?part=5


Thanks,
SJ
