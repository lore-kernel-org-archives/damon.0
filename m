Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183722F12AB;
	Thu, 14 May 2026 05:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737567; cv=none; b=eS6gj1NTszaZ5JKu8Oau4X30oEMxgiQ9q1j/VvlbUSenuSsKSmb/zj9XsCg1sc5pokhQvH6BilHYSge3s+GogXB904W1TOzwLqExfgdObk9bZHUplqwTIkvGWH1/p9KRPiv5T5Z3+BqevWk12TAWEMokr45idkLDH1CN6gBn2mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737567; c=relaxed/simple;
	bh=AV1G5GWfr5emeHHfbkF7efrdsykjmS0c9A3gornxl7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmd1UraSRfP3Kd3KC7Ii/Vw3LgJoAnSOI/n/pSsW4zqbGZGRiiwp1Z7N76hDfCXBHXx2do+42inZ2Ynnk3k55mR2MpWZplh6rpmm6C+vOGfQuQ/sBHujTQTdGI1WRN6J4V4mTEnNvLTtKSimT2NWQedr/eq7uEWTn3HnqCQaP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfBLcyxr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfBLcyxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31F8C2BCB7;
	Thu, 14 May 2026 05:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778737567;
	bh=AV1G5GWfr5emeHHfbkF7efrdsykjmS0c9A3gornxl7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MfBLcyxr7oUuYl7ZcTSDuhvrN2P9NtoKavt2BmZNt5WsDudkLUDTCemHNyV3angfJ
	 o2oSYWoK8AZ1FKrZTr/NrkcONn79BimLDEIvBxRwQfpyrOsgmYgIEdXOg/jApRZQBd
	 Eh2ftUuR6jewujQdzJ63L8TR4t9acCLskrgMzRAv19V+dFUr7PDx9qsx26AfRzgdMi
	 +E2alaUnIg+U0fOU1yOOYQt6fQiQiLd9sN/QCNmltoyY/RjOsq6K/tv8yfPOsgsEFZ
	 QiZgBHexF09v2xCPvkI51yRANa2E8AmfI6q/B2fatbVIExjXeAOuBhwaMsF4axZgOX
	 /+M+xBVa8Z4/Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
Date: Wed, 13 May 2026 22:45:57 -0700
Message-ID: <20260514054558.116481-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513050501.216835-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 12 May 2026 22:05:00 -0700 SeongJae Park <sj@kernel.org> wrote:
[...]
> Link: https://lore.kernel.org/20260419161003.79176-1-sj@kernel.org
> Link: https://lore.kernel.org/20260419161003.79176-2-sj@kernel.org
> Fixes: e035c280f6df ("mm/damon/reclaim: support online inputs update")
> Co-developed-by: Liew Rui Yan <aethernet65535@gmail.com>
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.19.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 64a140afa5ed1c6f5ba6d451512cbdbbab1ba339)
> Signed-off-by: SeongJae Park <sj@kernel.org>

Sashiko found this is incompletely porting the enabled_store() part change.
Please read my reply [1] to Sashioko for more details.

I will send v2 of this patch as a reply to this mail.

[1] https://lore.kernel.org/20260514054253.116346-1-sj@kernel.org


Thanks,
SJ

[...]
