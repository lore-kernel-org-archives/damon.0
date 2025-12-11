Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ACF70824
	for <damon@lists.linux.dev>; Thu, 11 Dec 2025 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765423813; cv=none; b=gZJtmvhp2fOs4wirENtbGalDgiuwJ3B5fptHwEwvx5IZwC1jdVErR3gyXQApDCn44K3i0GM+O6i40A91ODyv+cpO86ajBKFJNnHFdcs+zL+kMko3wtqaY6rm6twuLMaXOwUvZ8sVIF2z8Z3HeO8XQwnQdGQeg0mPaCsA9qsvom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765423813; c=relaxed/simple;
	bh=Z9L1QHHEtC/2SJYzILHjsr65F3Ix9ago3XyUR2DUFtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCahm6ihok+ZNJcTw9SYtTwxuGxntgIi2eceRGPSffhy2TFwcXoYiDiSAwjx2yyWpJszC36JrZ6jDF1QZ5Z6cZXXVkpd1UmYsufyKexrPsf8rRkt2E+u1DYiIvBSY+bRT4lmP8IbxgHdOLuHsvQ98EjbKpMdKViTQq9gJrFUBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrXrLFTX; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrXrLFTX"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64464de1c45so450262d50.2
        for <damon@lists.linux.dev>; Wed, 10 Dec 2025 19:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765423811; x=1766028611; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A+kgBa13isDA0TWyZlnig6dj5RwcTvhBOmcf0rRVr9A=;
        b=VrXrLFTXkWrJnei9enmZeZq888mYUTdkfEDQEo94ZD8G/HM+0Wm70SYISOTuV03ztC
         f7coBP5kyZc0IfhZRjUW8NxzzvL0Uf6XLEblirrGCuJk8tIMzu45MfxxXgtS2EGHVOYQ
         AiVmeUN/80HOlHjatbu8V95uKYZqWfNM2sXgT1y9FM2lpja/raXWlZOvSY0TwUCKJkyk
         KNWOij00iu0YQNRxiJYIX35XypUp93cWAjARBQ1w66Jxacqusy6Szb5uyfzKntXO9myh
         OZZ+GZ+xUmp/PaWyM+kV/pF4yETZOQ9evxRh4/oRVb2SM+njophBKDef3+XMBR53yVtH
         w8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765423811; x=1766028611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+kgBa13isDA0TWyZlnig6dj5RwcTvhBOmcf0rRVr9A=;
        b=Gx8/nl234nirGudtuKJTHWxBSvM/9vdL22kcXjQOfS/Y2KVzT1Dc0UeFjMJkJZYtac
         1oGftp8uTYpFSewAohp5CWoeuqtc9phORO8f/SC5ISqqzhq/LxnHsRvBPfR5i7amXoz6
         1lZIBe12nlHADkVEIWZtaOm1CI2guJy2sF4trsgIniazd9vkSxuvhWqb3jSlGlrXNcgF
         QUB9NXWAUAasUO1KPcKyv88OKscFtta6kkxjgY0IGOOsUyHS1dsAd1jKwIAngAaVY2CQ
         IDkjDvY5Oq8IMnyf0qpW+Abhdv5bpRZ8a2iVhCP46k3mMFpYLHLA/9B7NTEeGaIiF3/a
         gnzQ==
X-Gm-Message-State: AOJu0Yxg7rjnrE+5bjsz1ZET+kyGw3mGuL9WMpM3IPOLJPgnmWNckV2d
	S7d9fdHTeXH2JbXyjEhp+2pZy3ANFPSqrnGXsxOc/ES63uwzxCev1xWOgj1fgWuR+yT3MSeA7yn
	5iJO16EXWvC+8Vs3hrABZ/nykAjSv/fXv8OQiGyM=
X-Gm-Gg: AY/fxX79m7EI+8Dmhkdn4RzxcJqUIYNPEADwDo2QPmSxEo+9CtUj49yevIigWMka8tG
	4oE1BmW7bMUL2polpdnXGWXry/5q8lbTGWqFtLaa6zUVvDJpiFQJMvyjowerg9tQpiLz77s1j1r
	AB+UGaoWyQzWRzZtflujQOLz/Dzh4t4Kl3M3gt1/C/9zpMuJJh56KfbplkKQDVaEDYMHm1Eu+pi
	SYQDgQE51hmmB7PG+kf78mTSyRclit9OMq3H5gOK5fhwcsGu6jSbderB01zHQsWv06gaTQQ
X-Google-Smtp-Source: AGHT+IGx1i/hmxNAhGumNMn4ohfzd7BdjnbBCPqjWbQs+69758IpzoHPpanbHngMm3xv6KkbqhaIcmYer50SEAgvZm8=
X-Received: by 2002:a05:690e:190b:b0:644:60d9:7507 with SMTP id
 956f58d0204a3-6446eb5e004mr3726542d50.87.1765423811010; Wed, 10 Dec 2025
 19:30:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC6_-h1jQkZMbtYDC_jrB490jzp1t1Fx-_mhYnE7tqvzbw@mail.gmail.com>
 <20251210025400.51467-1-sj@kernel.org>
In-Reply-To: <20251210025400.51467-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 11 Dec 2025 12:29:59 +0900
X-Gm-Features: AQt7F2oJTFEnWJmg4wO_UeTkwCp5xM6MSBqPed-yCVo1NfNtcF-iEdE1q61GoxY
Message-ID: <CAHOvCC6bJLf=LuBpm90n5poz8Sqhz9wjXtk5ypbPwkvhb1ptag@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: modified damon_call_control from static to kmalloc
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Dec 2025 at 11:54, SeongJae Park <sj@kernel.org> wrote:
>
> On Tue, 9 Dec 2025 21:20:42 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > Hello, SeongJae,
> >
> > Thank you for your detailed feedback.
> > My patch has the advantage of removing the use of
> > the damon_call_control.dealloc_on_cancel variable.
>
> Thank you for keeping this conversation for enlightening me, Jaejoon.
>
> Could you please elaborate why you think the removal is an advantage?  I
> understand reducing code is good in general.  But that's only if the code is
> unnecessary.  dealloc_on_cancel is there for real use case, so I don't clearly
> see why it is an advantage.

I suggested removing the dealloc_on_cancel condition from the patch.
When using the damon_call_control structure, if you only use kmalloc()/kfree()
when canceled without dealloc_on_cancel.  However, currently, in other modules,
since it is static struct damon_call_control { ... }, kfree() is not allowed,
so dealloc_on_cancel condition is additionally required.
Because kmalloc()/kfree() and static are mixed together,
dealloc_on_cancel condition is required.
As you pointed out in the previous email, kmalloc()/kfree() has the burden of
memory allocation and deallocation, and static has the disadvantage of
increasing
the code size.  Both have their pros and cons.
Among these, I proposed unifying them into kmalloc()/kfree() methods and
removing the dealloc_on_cancel

>
> Meanwhile I find the feature might look complicated, or not well documented.
> Specifically, dealloc_on_cancel should be set on only dynamic-allocated
> damon_call_control object, but that is not well documented on the kernel-doc
> comments.  Are you saying removing it is an advantage because it makes reading
> code easier?  If that's the case, how about improving the documentation?
>

dealloc_on_cancel is only used in mm/damon/sysfs.c.  Here, since kmalloc
the damon_call_control structure, the dealloc_on_cancel=true condition is
required.  If you want to keep the current code as is and only change the
comment, it would be clearer to comment it out like this:

De-allocate when canceled.
--> To perform kfree() if allocated with kmalloc() when canceled.

> Btw, please consider not doing "top posting" [1].
>
> [1] https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying
>
>
> Thanks,
> SJ
>
> [...]
