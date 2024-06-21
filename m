Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C512F37F;
	Fri, 21 Jun 2024 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947445; cv=none; b=YeMP8vSUNyPPxq5aMo6YdnfHsEiEfI3R477ij5P9p1RfVGp2srMQaN9hq8ixzOaG/aq3M+ip0L5klk+1h1W/gYdOOUEWrZw0n6QrbiMxCKmnopnImOPM8on47f9c67/BtpO5Flcn+n/TtYDGpN/DgB2wGjaXFWOko8YyGAiyogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947445; c=relaxed/simple;
	bh=g0WAakIaFQpC+OLdKh1VM6cb4KXr2Y9sLumDaAY9VKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To; b=fYHo+DYYamCEFM/4EV6HiHZUUItAfT7zCyDBGlXRmQG4m7HyAZTVHxo6mSoyMm1ZFe22H0XhmSOA5N78tWjurcC6wKhIxEiVj+9kNt9u10OctoAbyyV8PdTMmiQ8oSkOIhfndQLPpL84n4DXERvrNip1sKcuswuPthGzRBGNdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chds0vtN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chds0vtN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF78C2BBFC;
	Fri, 21 Jun 2024 05:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718947445;
	bh=g0WAakIaFQpC+OLdKh1VM6cb4KXr2Y9sLumDaAY9VKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=chds0vtNyx7l8rW1mg8R4F4u25gqjfmC1GtYhwFHbtabLlaYaO7mKVQyPIbhlpwne
	 LImeDyhLpM6dofesRy1L1Iu1wq2eAuxtLb0oAmyWTz5J2Oqb/elSUx4UQC6M0oYSdy
	 mnAXgPsv3g504cCOaZH1AKiz2djCeQmSmIwTLFFIl5P+JdVvK4uNo9xOl9G1sqNRv5
	 lYLRpmMTxywwP+0wA6D1JqV3y83IwHCuPY1AiIxxHLnmJiRNCFrtdJbUsbNl49zPsU
	 +H0bbZRA9KXHqmhD+QZBSH+Kxz7YUANLVjnEWQ678xN0SGNJHP02vS2XAmke8I/Jq6
	 JPqFvZFV25cbg==
From: SeongJae Park <sj@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Docs/mm/damon/maintainer-profile: introduce HacKerMaiL
Date: Thu, 20 Jun 2024 22:23:45 -0700
Message-Id: <20240621052345.10279-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <5286745e-0100-40f3-b0e9-afc204c348f2@infradead.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Hi Randy,

On Thu, 20 Jun 2024 22:00:05 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,
> 
> On 6/20/24 3:03 PM, SeongJae Park wrote:
[...]
> > +channel.  There is a simple tool called HacKerMaiL (``hkml``) [8]_ , which is
> > +for people who are not very faimiliar with the mailing lists based
> 
>                                familiar
> 
> > +communication.  The tool could particularly helpful for DAMON community members
> 
>                    The tool could be particularly helpful
> 
> > +since it is developed and maintained by DAMON maintainer.  The tool is also
> > +officially announced to support DAMON and general Linux kernel developement
> 
>                                                                   development
> 
> > +workflow.

Thank you so much.  I will send a new version tomorrow with fixes for these.

[...]
> -- 
> ~Randy


Thanks,
SJ
