Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BED25A331;
	Tue, 19 Aug 2025 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584694; cv=none; b=TjZrxtXcM1kQI+SIMkPAQJlCcsXjDpS35wqyhadFEAAjo5cAOAqzN6qZdciad7ZhRCll1dp/wQtPM9wulLRhiJggGasd1OZW44WRlqPtW2EFxgoi6rvNyEiShomruvN9nYqKDU6fuM6Cn5aaoQ6WT0RxakzZF3X2vYkMD9+PVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584694; c=relaxed/simple;
	bh=PmK866isOoMH40vJFW2CqVN9q5hJL/Ky2XXJJolQ5Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BGI5P1fQ9/y9WznUy7776aklH6MLJFsC9JgeEI+HusfHa8AFP0vMFNeSR6MvuegV/lzTDd/6K1TXY3aA1TWwJzFotyrQE46AWiHNWuhhbYDM1H8r1rAuS0XT4+OanOoMvqwm2Qr2JLcUmMgxflKVKkvXJqn1HZKCYpNypGIiRQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rS8NUeI6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rS8NUeI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1630AC4CEF4;
	Tue, 19 Aug 2025 06:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755584694;
	bh=PmK866isOoMH40vJFW2CqVN9q5hJL/Ky2XXJJolQ5Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rS8NUeI6mNOKxB80MNRrzJSoFqjKUnJrsDCeqQ1DolXlMGG/qUAbmqh5kUBBydsNs
	 rSHikRGaZMsITrZgqVyLaYkDafaU2vmt+kRhrLn/+NCzCdG8zbo0UoDYLHqwVhdIAg
	 7V00GbMyWr/X1DJzAwNT6HLePngPcJ0OoCxA0NTHz91/OEUwbt9hlo/JPQRVWvpQFd
	 1mNwOScDSycp8K1wn93YeerucJeDLPifvmbXkHCTbCS+qkkLYsykWKTwVpWiywSgeO
	 fC+Q5/SiALYPUL/GAgEfQpssUt9znQK5tb8TNto7S1zlsv04MEGShJ3MV7U4h78IUF
	 wkJBnF0EAfWvg==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 07/16] mm/damon/sysfs: implement addr_unit file under context dir
Date: Mon, 18 Aug 2025 23:24:51 -0700
Message-Id: <20250819062452.39889-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813050706.1564229-8-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Quanmin,

On Wed, 13 Aug 2025 13:06:57 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Only DAMON kernel API callers can use addr_unit parameter.  Implement a
> sysfs file to let DAMON sysfs ABI users use it.

As I suggested on another reply[1], please squash attaching patch to this one
when you post next version of this series.

[1] https://lore.kernel.org/20250813170224.6128-1-sj@kernel.org

[...]


Thanks,
SJ

==== Attachment 0 (0001-mm-damon-sysfs-return-EINVAL-for-zero-addr_unit.patch) ====
From e0a5aa5e571ecd0f58b0914f8fc8562a60014ae8 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 13 Aug 2025 21:17:03 -0700
Subject: [PATCH] mm/damon/sysfs: return -EINVAL for zero addr_unit

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index bea782b0a711..eb4269383bae 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1422,6 +1422,8 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	err = damon_select_ops(ctx, sys_ctx->ops_id);
 	if (err)
 		return err;
+	if (!sys_ctx->addr_unit)
+		return -EINVAL;
 	ctx->addr_unit = sys_ctx->addr_unit;
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
-- 
2.39.5

