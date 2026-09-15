Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467264A49B2
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484028; cv=none; b=U+kJSs//4L6acyzbP8O/JMGObcrOoeveK5BMXTJ/35m7bShDty8wg55ClpmwtKpCyXxOVgbcnzQqoJ3EsDe8Fbj+nZaXha2IXEWMsgrc6ZzdZ4KNDyZhunE09OhXV0bATAGdAFP8hgcYyYXohShXR/QIGONhMiFzt1XGFQVNhlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484028; c=relaxed/simple;
	bh=JJAzDF+b4166mJNwlyZzw7hI28Fp8kOv1PfzC+vlPT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNW/ZTKSLJt5rHFe/GZP/lBwGIpnEYjYmO4gCtkLkonUtiOSwzOVy2KQEloXvUzWCuNOcAPwnBbw3JRloX86TzGjVY3hjXGp08CjTuALCK3Zrs0wwwcyN1a3o9SdoK+B+yXr439/nouxLovem/Llq6lKtZ+lkeCmsaNtSX0a88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9Hu6w1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9Hu6w1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51601F00893;
	Tue, 15 Sep 2026 14:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789484026;
	bh=mtOpF8ipadZzDsv00mxqby+pmjJE3UrVcCaSE4QEfXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f9Hu6w1ZJzwTLOpCrnVfLOYYPxlr1Pte7gWIrcYA/1SfDrFxAQyOFbPVOYzXbWFtn
	 bEjqCCwNUbVRAML9/cDCPMqpHlTdB5nk/cRQ1/vLtsVtnsm8xwNm9JqilMBakixRNN
	 +cZ+54eKp3WoCJ76wNHEoR5RLm3+mYID+00BJ5LZe7bqg378Goj8sdOHfGUrcJ3cj8
	 Myb4aRTV+IKOyZO1lhs0pnHhjPe4mWTAnyFjh/M3KKTX+0CZGW5TOkD7Z2S7z88FWo
	 2AuEGjG0wXMwWjEOWsxac5CFm+1oXWmgjlQUTRNTIyjlRZik7/GGJfvq70rikHS/Ep
	 p6F9b/JJUsXaA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 7/8] Docs/admin-guide/mm/damon/usage: update for hugepage_size
Date: Tue, 15 Sep 2026 07:53:38 -0700
Message-ID: <20260915145340.92172-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915143949.475871F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 14:39:48 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] doc: grammatical error in damon usage documentation
> --
> 
> commit f587d7d9920741b1ef2aaf02c04d27dcea002f5e
> Author: SJ Park <sj@kernel.org>
> 
> Docs/admin-guide/mm/damon/usage: update for hugepage_size
> 
> Update DAMON usage document for the newly added hugepage_size data
> attribute filter type.
> 
> > diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> > index d3e37400367bd..6b80bce5d678d 100644
> > --- a/Documentation/admin-guide/mm/damon/usage.rst
> > +++ b/Documentation/admin-guide/mm/damon/usage.rst
> 
> [ ... ]
> 
> > @@ -308,6 +308,8 @@ Writing a number (``N``) to the file creates the number of child directories
> >  named ``0`` to ``N-1``.  Each directory represents each filter and works in a
> >  way similar to that for :ref:`DAMOS filter <sysfs_filters>`.  When the filter
> >  ``type`` is ``memcg``, ``path`` file acts as ``memcg_path`` for :ref:`DAMOS
> > +filter <sysfs_filters>`.  When the filter ``type`` is ``hugepage_size``,
> > +``min`` and ``max`` files acts as files of the same names for :ref:`DAMOS
> 
> [Severity: Low]
> This isn't a bug, but should "acts" be "act" here since "files" is plural?

Good catch.  It is too trivial to respin the series in my humble opinion.  I
will fix this later unless others do that in near future.

> 
> >  filter <sysfs_filters>`.
> >  
> >  .. _sysfs_targets:
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260915143359.91472-1-sj@kernel.org?part=7
> 


Thanks,
SJ
