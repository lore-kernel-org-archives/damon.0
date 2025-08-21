Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6133C277017;
	Thu, 21 Aug 2025 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796978; cv=none; b=fqGNgLuwEPJkAz+ler5VAM7kK73DHs2isIjw6sIQatCFJGgWo6D1SwgtkfSRa8oYo6ETKJy87qDh8RAzeBDjyKBfojqq1E0gfEq1JONEoOpsJmIWAYTN21h25Lkx8m59THz0Ech05wm+FQGGmJGu0WCr1ZzBDkI4EruMnDYVpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796978; c=relaxed/simple;
	bh=WuobrIU/w6/7bz5ni6T/FPagEIkFDuKLi573JKcu5So=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vtmb8MoxJsUayAPFu6Rk92IrfXTrAVCraR6Umo4r56rGUkS8/7RHKzCNGZ3eQrDveNLFCWBBAd2bhZORVCjyqNn5Khhzb8v/W47e9EPy7h22sgq8qH435Ngkgr6fwzfARku7N3CL3ECdtLVPsKZj+7a8aVfqvbrplgQr1/t0PGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3UYJcBY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3UYJcBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C2EC4CEEB;
	Thu, 21 Aug 2025 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796977;
	bh=WuobrIU/w6/7bz5ni6T/FPagEIkFDuKLi573JKcu5So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3UYJcBYfqTdzeM3cc/mYqxGLnz8jpW9wKntxSB4wmbbb9AgsT9Jct8PBoGimkWkp
	 QBgqkbhp3bDdBN7fbjlveapRaJ6olz4W/Ivm1kDLDT+p8jDLoFIPEHYu4gmdTPtr++
	 iRn65sm4sjM9EHezl5vJx9O2guQC6TKTHEcPpa9AzzhE61OUQVycZfhvIT/Ke6RoUp
	 01WMJR4bmnhle7lJsNX9cPNM9obyf2sY9shacoICXvT/itLLneJ+7ESGoO5aTTRbAy
	 3JBtanM47mXL7e6lgKyP7572uBakPkTFh2oP3cxkMPMxUL2E6LCDR5jrQ/t31ls1rQ
	 mUWkbdD3BycWA==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 08/11] Docs/mm/damon/design: document 'address unit' parameter
Date: Thu, 21 Aug 2025 10:22:56 -0700
Message-Id: <20250821172256.82263-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821105159.2503894-9-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 18:51:56 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Add 'addr_unit' parameter description on DAMON design document.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
