Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5114B08E
	for <damon@lists.linux.dev>; Wed, 16 Apr 2025 03:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744772687; cv=none; b=WGgcKfPStiadtHyUamx3bI2A019Bb06d2d9cieio9wNJq7C3OIIMo6jMS3iAWB9cw0ATK08W2DCyRZQIGpFT8KTPiln7bO6OvBMv30AUi43WePV9CDoZv/Yay1iaawPQ+ExlcKDXrPDpo+OWy7UGzHKooyTyEFgiVJmYNh24L6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744772687; c=relaxed/simple;
	bh=kfNs5cmFD3ftCaFPLLvrLZvR0Tp1cetdS/+GkWRIQhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NclV85UvhsJAl4ruoypUseEa9p+++CXhZk5in8mtszEBI9XWUQajlVZnm4VV2vHk0SYFiUFpdMaCg79/zxd1OrNC9ivm4pW8F/j0/3EU2/Ogu/fJuYDXxCCYSbPfkb0Ycd3dXOkO56GN9J+EaTdgnSQ1/0hWHHKyb5S00nWnHqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzpVxvtd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzpVxvtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD08C4CEE7;
	Wed, 16 Apr 2025 03:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744772686;
	bh=kfNs5cmFD3ftCaFPLLvrLZvR0Tp1cetdS/+GkWRIQhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AzpVxvtd4sCtHzDRf3Awv389c8V9rIF1hNOVKrjw8vGQd/kwNCi5Pli68yhu3im4z
	 YDJs8k0kLFR1ChPs0zJlh7OeNZEkHvPhHj8uBsBZ8ndcpGfa0PT1pwkKZ8qxAnbAIp
	 E74CSvr1DtchiIabYxsgD3zRacUzzQ/qqUrXWHgvVGARY1cNaFePbB25WRaOZjKwq3
	 nflVuS62nQH+JqTOldwSrubj0Zb/cwZ1bwaVsLxQz8w3dawdwit5zDIaaSTxV5iRlS
	 zgKD9F7DR7KNIHgKYdBEXwuWNab2ipa2qfr9UVtWoxBFKs+Lrp13AZYY2jXtfOMNlG
	 o1ilCauEDRfzw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Enze Li <lienze@kylinos.cn>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] samples/damon/prcl: Fix a comment typo
Date: Tue, 15 Apr 2025 20:04:44 -0700
Message-Id: <20250416030444.156316-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411163650.65152-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Fri, 11 Apr 2025 09:36:50 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 11 Apr 2025 15:38:00 +0800 Enze Li <lienze@kylinos.cn> wrote:
> 
> > This patch just fixes a typo in the comment.
> > 
> > s/regiosn/regions
> 
> Nice finding, thank you for fixing this!
> 
> > 
> > Signed-off-by: Enze Li <lienze@kylinos.cn>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
