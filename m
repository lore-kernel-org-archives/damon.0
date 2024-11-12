Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859220ADFA
	for <damon@lists.linux.dev>; Tue, 12 Nov 2024 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442794; cv=none; b=apMzx97fbtzuoGglYjTdS4dYckOSOQUfUxNWuKLcZejLESoyYepqW2koynxpm4PbMkr/xBYz+MFoEIwkHYUeC3G6pwQ+FKGuR6uNw60Bb1B8nxojFvsLCcTNdnbsbVtol5q1TCT1kUL1/5bbby0gImeYSUI7/uKCHByR2rEsgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442794; c=relaxed/simple;
	bh=wmR2IvAe3Th4QbwhZONZ70cNFXbTc04aGIsxCfo6wHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QuUAQZyAxsC8SLrHlYAFiepTT2wXlOElr3hDvT8QAlZm82VVd6Ggyb746I1veBmk3HfVBFwMBfaU9KhYi91qz1lJtXiIa6imI60Scb99k7xsX2p/ZD3tX08C8gv9grmEwZODsSbLzziSSPF8K03tqmnqSOE5qkHdg+zpBu7WD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrL3BR2l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrL3BR2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B192FC4CECD;
	Tue, 12 Nov 2024 20:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731442793;
	bh=wmR2IvAe3Th4QbwhZONZ70cNFXbTc04aGIsxCfo6wHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrL3BR2l63cTKUPQwaHyxKiiCPYG0r4f2YwrSHLLkgHPCZXuMaZYuLinjxfDulsEO
	 CEyCJX6wMXDdDYsbUp9OGaGJdDAMuCCQT/a0/hBK1FJqNmR6pgbEBuZBid5kPjHWUS
	 jyrwRUVm+6GbYIz3iJYEAH0q3NCoIwn/o6UqY9OzeZcHvsPH8dNCkSBnVN5HI2Mrnl
	 0uG7q6cy2qjzBCS1qPWVRWwx+17LzatFnYrUueF1y7TTZoKSfekHvC3ZwMOLAWgCc0
	 Rd0JiRwRBB4C1EblwjG3YWHgXgPO50NYSBCsF1ZVNabjvTYGQGMtH4YKIbFHAvPZCS
	 z8ZWlZZedZl2Q==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: fix order of arguments in damos_before_apply tracepoint
Date: Tue, 12 Nov 2024 12:19:50 -0800
Message-Id: <20241112201950.42568-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241112154828.40307-1-akinobu.mita@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Akinobu,

On Wed, 13 Nov 2024 00:48:28 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Since the order of the scheme_idx and target_idx arguments in TP_ARGS is
> reversed, they are stored in the trace record in reverse.

Thank you for finding and fixing this!

> 
> Fixes: c603c630b509 ("mm/damon/core: add a tracepoint for damos apply target regions")

Can we also add Cc: <stable@vger.kernel.org>?

> Cc: SeongJae Park <sj@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
