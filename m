Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168831B803;
	Tue,  1 Sep 2026 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222074; cv=none; b=lbSKwA0FzVjaq3ApoUvIMpm1CUjXjNFq3iVHRCFvtWAAYXRDJ8RMtJ2rxclorLnuy67N0XPpkcTZMyVgxMUWx1ELlNdG6sJqFa8NahteFwQi6ZZe8GVQK6lD6ecm6+VRuNmcaHXoeKKLlfmnU/08HuNkWGYhxNWtHB2kim7J4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222074; c=relaxed/simple;
	bh=64CSXebaNyiMgoj4hSV15pKZhzEDvXV6lhK7ZQo+YQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJTzW8wQV2zAOFjrAF+j0lhxpmirNdAnExM3ZzDFlkvAXroKhgxZqGPfr6seL5TGYCexntQAbUmCk+efZR0m6Lrss5OdmSLDunpLy/qQGO8dgY341ToDLXJD5vWSkeqzT4YnwTB2g2vapTNaP08UkKid188JWXZ5ppxfIwCXBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhSEG2rY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhSEG2rY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5DC1F00A3D;
	Tue,  1 Sep 2026 00:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788222072;
	bh=jvKfPqEJVRTzFEJl0vjYm8BOKR3lZMkGSjjbcfR/pCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RhSEG2rYYG8OYS0Gu9ieptC8nln09mqp5PuYXNS69SJ7mmt3rarE2CioRnIFGqolE
	 VJ0305JlqTUZeZ7b6Euqf0j/GJmIAbINze1JJefuNgc3fhPYtPoKBS167+zwDcqVqw
	 W1acn+wgXEucT6qFQEOpt0JYV1lRWfOI93RJbG2udkrAMMmDJZIDmMR5xeKEgB1tZH
	 APAQ+WJcYhArilZMw+F2gFUzg49+QRpM8SUZfpiVuqWlvL9ZUoUQXSnFL55Ubsdb6Y
	 o4P0WNo68sS3ik9yRJS/nqa31FdcB8A0BzT7KN3+N+2CtXqFNsqWlVJ28HKe0bp9dU
	 Iwok3SPKnikYg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] mm/damon/core: fix unconditionally skip last region
Date: Mon, 31 Aug 2026 17:21:04 -0700
Message-ID: <20260901002105.88435-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831005834.5270-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 08:57:56 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Sun, 30 Aug 2026 11:38:51 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Sun, 30 Aug 2026 16:29:46 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > On Sun, 30 Aug 2026 06:47:07 +0000 sashiko-bot@kernel.org wrote:
> > > 
> > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > 
> > > > Pre-existing issues:
> > > > - [High] A preexisting bug causes DAMOS scheme application to permanently stall for all subsequent targets if `quota->charge_target_from` points to a target that becomes invalid or loses all its regions.
[...]
> > > SJ, when should this bug be fixed?  Along with this patch, or before
> > > this patch?
> > 
> > Whenever the fix is ready.  If you don't mind, I will take this.
> 
> I do not mind, thank you :>

Thank you for confirming, Liew!


Thanks,
SJ

[...]
