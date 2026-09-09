Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8454B04BB
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948544; cv=none; b=LpdEvyxvAodoNqjZHcOhFQ48K2hoz/BZ7ZPKFrVch8sCNBxy9j6dKj2pNPnSRUYkdoiIGKOj2cxuoMMXAgzYqov+c2MPteqNpkCFg8yfIcM8kedNtF47Eo9QMLStKnrN90J+E40bpNFd6q020xjBcLr6/6H8+dZRzRDaRyfgv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948544; c=relaxed/simple;
	bh=YnBXD+T/yH9/YjPEUD5GRTVBzz7NWd4Ym7TZDeqX61U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9mfFvgdjQBNXpp6GxG6sJ6BDUbtbGoKM2bRIliX7pPiQKTLjHjk1nT1zii6vqFDBSiemVlwClKIR4qQ8VBHw2dEb5c//p0BN/ZQZE7X3RhUGwZawskFVlhRLQRPT/MM4uXqjhfzogbqvFUU1UBbBtaMXgzKic63RYkWoYFASHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSz8hEJg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSz8hEJg"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-851cbd64814so2910481b3a.1
        for <damon@lists.linux.dev>; Wed, 09 Sep 2026 03:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788948542; x=1789553342; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cspt3kRXGk/I1h0yuaYP6XGwO6IhBwUrx4BknaruqsY=;
        b=lSz8hEJg39xNwZ+XSqvJzKBLV+BTSytYcUkczp5gShkqAERbIBW6P793mLlYm0skAz
         TXGAOc+H5nQ8fHJTj2rnYIaSEIrAeFbF0Y1WXPXnkQHfqOYh0z84Ax7rNQoA8+f8knyl
         SWSLyqx7eS1I2SAY9sXtu/yTDsgvNkYZvCeLrPyuBci8/YvAFwmyIcJuama0ioVfZbMD
         7mqA39YfHfwRrWlybCmK/bKvukRmsFh5xxghAHqV+ybYnyzJW9FBoe3HifVifamRj9RN
         9/1x2FKFvOhz6KJYmIV+foSpGpciLBGHFH3KHr/36bXPl7KU95y0rvEVLfgpW+x+EQNV
         qHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948542; x=1789553342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cspt3kRXGk/I1h0yuaYP6XGwO6IhBwUrx4BknaruqsY=;
        b=L/Ny/iJRDBVwWFw/JbHsFcqQgP8IPWx70RbXrMeekKSc8uSE/zZGhHJHINa0FbTsPf
         HHaC4ooxj+JxFneiUYxOxisLSF+CYPuA1jYee3459mxAaHwVYAGE1ToFD/yDzdBR1Kbf
         m0Crfnh4v3Zl4sR2DgI1Ia3YF4eHx2XqB8nX0K9BnBbnbvzRWsw61qrArkFxgAeFnEhL
         hWY2D9fTr7G061cz2md27w93/upkw3t8LG+BP5Z3Fl32XOol65H9oZJGuo+tgDir8AP/
         +5GmHH5mahGYfs1mCeqKWLO90wVn1ItolYEl3Kcq+2JG1kLpRKgKofQrY39lM4cAr2Qc
         80YQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmISFVoX2/1IIWkoI5OyK7VvJ+od6DHMLLAy2BWdgIADbUNi1CCcfYNYX3GOu5XwDlLehpYw==@lists.linux.dev
X-Gm-Message-State: AFuF++kaNS/HFgOPeIOkn1o5LbJup13gAkKqU/9YsH0Oa18N8FR6i6e2
	/qdbibliM09GfcgQWB+znOSH6cOq5cCKv87WUmIkpNX+NiQr0NwQKHGc
X-Gm-Gg: AYBFou3JtOhxXmQtgBuXlRGsUenxZyOrlf47ZFBTwkV50wd9nkc6SSmxKekancp1Uvj
	wtGWr1SZLKtFidYyRMXKfbYCCnZIztXAB45vu6BsurcQmLpoYYZf7JIPghG/u8ihH9+ktH3IuK5
	9r/ygOQp+t8bGjGbB9VtW6pkiA+M7NAhR8CXynm9sGOc8vqL+uIQK2nJbH+VLPbDgLICOzE5oee
	lTbDZuEQdNY0NbKjPN2w3P8tgN/njVMqByYP8ygJFnVZf4OrXj2WCa8Q6otd8EG8+JkRWoJtbDL
	PZdiYMMgE0IaDD+DRvBk6dseCxj3tjPwH3cBJ+n+FR40JjCzwAFcxAXCTPRXVRkvyyRL8Oq0DZw
	UaRvZ0S5srURh9Zqk/Wi9tTSpxvdHY8mRN6EBE+2ZSUul08zD4E4PUOnbxdnzWGbm9959luYh4/
	sGyappkPf/kNcm5F1B8w9Ge6ox/MS0JhjYg64iTHJg5HX6Y8oY0v4y8kF1pcd+ab4O0REb1xIEb
	YozlRgmnIllC3E=
X-Received: by 2002:a05:6a00:2d91:b0:846:8b22:4933 with SMTP id d2e1a72fcca58-8616bd5c57amr45991902b3a.17.1788948542332;
        Wed, 09 Sep 2026 03:09:02 -0700 (PDT)
Received: from celestia ([2402:1980:885b:4183:b098:c1b9:7033:be8a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152c2a52asm6745792b3a.30.2026.09.09.03.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:09:01 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	damon@lists.linux.dev,
	david@kernel.org,
	liam@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	rdunlap@infradead.org,
	rppt@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@kernel.org
Subject: Re: [RFC PATCH] Docs/mm/damon/design: clarify when qt_exceeds increases
Date: Wed,  9 Sep 2026 18:07:33 +0800
Message-ID: <20260909100913.30568-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909003800.112569-1-sj@kernel.org>
References: <20260909003800.112569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 17:38:00 -0700 SJ Park <sj@kernel.org> wrote:

> Hi Liew,
> 
> On Wed,  9 Sep 2026 01:50:23 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > qt_exceeds counts how many times the quota of a scheme has exceeded.
> > 
> > The value can confuse users when the effective size quota is zero,
> > because a zero effective size quota does not always mean the quotas are
> > unset.
> > 
> > If the quotas are unset, that is, both ms and bytes are zero and no
> > quota goal is set, qt_exceeds never increases.  But if the user uses
> > the temporal auto-tuning algorithm, the effective size quota becomes
> > zero once the goal is [over-]achieved.  In that case the quotas are
> > still set, so qt_exceeds keeps increasing once per quota reset
> > interval while the goal stays achieved.
> > 
> > Clarify this on the design document.
> 
> Thank you for keep working on this with patience.
> 
> > 
> > Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> > ---
> > 
> > By the way, I found a thing in the design document that confused me.
> > 
> >     temporal: More straightforward algorithm. Tries to achieve the goal
> >     as fast as possible, using maximum allowed quota, but only for a
> >     temporal short time. ---> When the quota is under-achieved, this
> >     algorithm keeps tuning quota to a maximum allowed one. Once the
> >     quota is [over]-achieved <---, this sets the quota zero. Useful for
> >     deterministic control required environments.
> > 
> > I'm not sure if "goal" was accidentally written as "quota" here.  Would
> > this be better?
> > 
> >     When the goal is under-achieved, this algorithm keeps tuning quota
> >     to a maximum allowed one. Once the goal is [over-]achieved, [...]
> 
> Good eyes!  Yes, seems it was only mistakenly written in the way.  Please feel
> free to send a separate patch or include it into the next version of this
> patch, whatever better for you.

I will send a separate patch.

> 
> > 
> > ---
> >  Documentation/mm/damon/design.rst | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > index d036340dae8a..e083b74d618b 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -863,6 +863,16 @@ scheme's execution.
> >    completely tried to be applied.
> >  - ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.
> >  
> > +``qt_exceeds`` is increased for schemes with set quotas when the quota is found
> > +full at a quota reset interval boundary.  While the quotas are unset,
> > +``qt_exceeds`` never increased.  However, a zero effective size quota does not
> > +always mean the quotas are unset, if the ``temporal`` :ref:`auto-tuning
> > +algorithm <damon_design_damos_quotas_auto_tuning>` is used, the effective size
> > +quota is set to zero once the goal is [over-]achieved.  Since a set quota of
> > +zero effective size is always considered full, ``qt_exceeds`` keeps being
> > +increased once per quota reset interval in that case, until the goal is
> > +under-achieved again.
> > +
> >  "A scheme is tried to be applied to a region" means DAMOS core logic determined
> >  the region is eligible to apply the scheme's :ref:`action
> >  <damon_design_damos_action>`.  The :ref:`access pattern
> 
> I think the clarification is better to be added to the 'temporal' quota tuner,
> since this happens only when it is used.  Maybe the clarification could also be
> shorter.  For example,
> 
> '''
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -775,7 +775,9 @@ There are two such tuning algorithms that users can select as they need.
>    fast as possible, using maximum allowed quota, but only for a temporal short
>    time.  When the quota is under-achieved, this algorithm keeps tuning quota to
>    a maximum allowed one.  Once the quota is [over]-achieved, this sets the
> -  quota zero.  Useful for deterministic control required environments.
> +  quota zero.  Useful for deterministic control required environments.  Note
> +  that the zero quota is a valid quota, and therefore ``qt_exceeds`` :ref:`stat
> +  <damon_design_damos_stat>` will keep increasing in the case.
> 
>  The goal can be specified with five parameters, namely ``target_metric``,
>  ``target_value``, ``current_value``, ``nid`` and ``path``.  The auto-tuning
> '''
> 
> What do you think, Liew?

I agree that would be better.  Although users might look up the
definition of qt_exceeds first, they are also likely to navigate
directly to the temporal section.

I will clarify at the temporal section in the next revision.

Best regards,
Rui Yan
