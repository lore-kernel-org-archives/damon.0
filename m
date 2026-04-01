Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1633B6DF;
	Wed,  1 Apr 2026 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775073135; cv=none; b=ZcVEdUvmtbFUvCANFvth2ECAl9MmqTc9TBY08gFVOYPKZbjpvHtU84vNjZFQ5xSGigfRCjJ8PPimA9iFwfE2cLYAb5qrKbCjp1Htx9n9s99wFozus2QeBah0VLXKI/19006VDiXS2kRlhaUUCHPwvqJSpE4MiSb89y+iTeEXiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775073135; c=relaxed/simple;
	bh=8td1vtx3iaV4CtFL9W4NINSFT/pfU0MJKyD0q1yzYto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBJ4Jm4GxKKmu5IoxQ8DOl08S2KqIueWCPBP+VJ2CfLrq1zRtZpxdneYc6si3fHKkgyI1UMWc/z8jINXTlc8T1bpI1hSejZgPXMsPQ3xS3e69NOKhghm7d1X1xXw9t3jlvOz1aWkyBTzNMkPoLDIbfO5xuzclEL25j8/2ABp5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iegSTeTG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iegSTeTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DE2C4CEF7;
	Wed,  1 Apr 2026 19:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775073134;
	bh=8td1vtx3iaV4CtFL9W4NINSFT/pfU0MJKyD0q1yzYto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iegSTeTGSkpbx6uOdKbaa8PHajPSmamUqAiudCJYUsPCcuLVNjTo1tvyvUvrkCqR3
	 9PacvUB70x9rntJXq5Z9ygVn9H9cXaigsf7s1ZgTiMMksEM5a8MzCMydoLY6eUbGhK
	 fS2nDbywhQpw9F4x1B5c3+7wddNV9cJfHP2pe/EVgQF6gsmW29AXa3vnG5chEdzJnZ
	 UoensbbOEhn8P9X55bLGfG2z96MR9575K2exh8ZmzSznjfCT/BCiGXePnJUhVLS1HP
	 eB1M3M98fPym2kwn1QaARVC8+Nzt0uokKWzse5O+y4GMtr5TFy3pJJ5InJ+dLJWfJN
	 7GVqLRLZdRUXA==
From: SeongJae Park <sj@kernel.org>
To: Vishal Moola <vishal.moola@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: add sashiko as the first DAMON reviewer
Date: Wed,  1 Apr 2026 12:52:12 -0700
Message-ID: <20260401195213.68900-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ac1fOrrURjCfQyJY@fedora>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 1 Apr 2026 11:08:58 -0700 Vishal Moola <vishal.moola@gmail.com> wrote:

> On Wed, Apr 01, 2026 at 09:26:36AM -0700, SeongJae Park wrote:
> > sashiko did arguably good jobs at reviewing DAMON patches, for multiple
> > cases.  "Today" is the greatest day to give sashiko a credit and the
> > responsibility.  Add sashiko to MAINTAINERS file as a DAMON reviewer.
> 
> This is a great idea! Andrew should add it to the MM one too :P

Why not 'THE REST'? ;)

> 
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 16874c32e288..42aeaa858531 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7041,6 +7041,7 @@ F:	drivers/platform/x86/dasharo-acpi.c
> >  
> >  DAMON
> >  M:	SeongJae Park <sj@kernel.org>
> > +R:	sashiko.dev
> 
> Maybe we should give it a kernel.org address while we're at it. It would
> look more in place.

Oh, so that it could use kernel.org infra, right?  Good idea, but asking
kernel.org address might take too much time.  I will move fast and break things
by sharing my GPG key with sashiko!


Thanks,
sj
