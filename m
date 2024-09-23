Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257AA28E7;
	Mon, 23 Sep 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109152; cv=none; b=LuvW0bQEu4JDUpA3DV2J1xppxKhdDEmYuwDdUktZ6GPt5FtwP/kSdQ+S7mxyaQ6r6nPZcL3niiufjW5ZkryB3OjMlpkP3AAt3ysXwTKbqltTnnkemTINe7oDylB/QRwinG/lu2JQC6q46vMkV5mKH38XTMJCbcA7vSZNn8yXcYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109152; c=relaxed/simple;
	bh=YO604i0btXRLSH/R8dJ9t/pxBIj0haKRMoLVAQlx9K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJq8R14RBUs5FWX0+m7NglU1N18RVSPuDtJfleDqAgKHrsUEULTnFKbZ1tdysLEqpzaoXMNXTi2fgNFFRWEopWMsaChbDHvzN7wK7txCKav24cdmz4AhMQhq+PVJsORjfDWJpejOHsiKRTA0buh0W9wtslOtViGLPytfXxL0V5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxSPPala; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxSPPala"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272C4C4CEC4;
	Mon, 23 Sep 2024 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727109149;
	bh=YO604i0btXRLSH/R8dJ9t/pxBIj0haKRMoLVAQlx9K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxSPPala991VsSBaiVSimW1aA+GV1B5vn9mkxN1LmSZxWdLQG/XYFTNRuHm5mNdKd
	 DgD9a3TrfhGbYBBuhurhDF/4OLsFVl7ZtpE/ezJFPFBiVyJXQRUHX8TUXY5fQ2UErq
	 uhw79E2wStEWwWgcGBE0FUm0Q9iSjZQ4kS4BkA8NQCrW8av3I/RxEpkj4jTy9jyfdd
	 FrQlonj0kt0r51u6AvtOBzM3nk1jKG+xFIrVjr735jOx9JGJg2JOZ/IWKrxsSyd5zc
	 kmhYpD/U/kEytV1rjqYC1QuYzLLzLGckNjteEJMtsg/2NmLCgXzsOldSe2prWE6iyB
	 ZHSSnHzbd59qw==
From: SeongJae Park <sj@kernel.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Update DAMON doc URL
Date: Mon, 23 Sep 2024 09:32:26 -0700
Message-ID: <20240923163226.550729-1-sj@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923100615.14160-1-didi.debian@cknow.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Diederik,

On Mon, 23 Sep 2024 12:05:58 +0200 Diederik de Haas <didi.debian@cknow.org> wrote:

> The old URL doesn't really work anymore and as the documentation has
> been integrated in the main kernel documentation site, change the URL to
> point to that.

Nice finding!  Thank you for fixing this!

Nonetheless, I'd prefer having 'mm/damon/Kconfig:' as the prefix of the commit
subject.

> 
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

Other than the trivial nit,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index fecb8172410c..35b72f88983a 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -9,7 +9,7 @@ config DAMON
>  	  access frequency of each memory region. The information can be useful
>  	  for performance-centric DRAM level memory management.
>  
> -	  See https://damonitor.github.io/doc/html/latest-damon/index.html for
> +	  See https://www.kernel.org/doc/html/latest/mm/damon/index.html for
>  	  more information.
>  
>  config DAMON_KUNIT_TEST
> -- 
> 2.45.2
