Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0E32B12F
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898933; cv=none; b=DVAAXWEl+8Ow17Je1VhS+ufUfRCL7XKAGcxskxORcGSTa07+JJ8PTw+DiNH3ShWgALTsN6leNsKEazPAMVdDxdNQl2QZ4PJ24V9/pnFnENtCpoqVu9GljtInCgLCwz102d6uVSkqGV7Xr0IQNg6r0xRrxtHp8fTW9OGcT67k8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898933; c=relaxed/simple;
	bh=wf/KKXgUPtSbR6ajXt20dnGgN5lMl9YW7qtTWNdXQuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLOUfxAwzolB0ZQFlk0k92PEa0RjXjXIqm+KFrW/wiau7HMU8/4t+IcJrzOII1Onteg4zXnFJJHSmdWheW54owwBAeAumrYrFlVOjp03w1RKH8SF+BNqI8qccrZ6f7XxmQFsjtPWry6CCYHrIjdEkRP5xgzsfVFyusbipzRGCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBlGnvGn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBlGnvGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1A91F000E9;
	Fri, 19 Jun 2026 19:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781898932;
	bh=wf/KKXgUPtSbR6ajXt20dnGgN5lMl9YW7qtTWNdXQuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lBlGnvGnCxrC7MMgbPjT3CfE9wajMN11U02qHjauhcMHVMy9LsnD8ZlqePEQe6ZHU
	 hASPIcKsmf4Rt+0mTZ2ozCHUidlN3BTxsXDxhurD157vuTdXTyYVIoWOqEwsvTH6OM
	 OHYla2GWpNFTTvu2kRX5PdaWIoitjp0sc4eTpY1VdfBx5RuY2h7t9ramcxTXS2gQCf
	 esT7/yvbcakG34Zq37i76gR4EY6TMct8pQpDdmzBENbqYX5tOJv6+sA2akeaheE3N7
	 NRbhLjB3VEA0kCSQGURtQ9foHtacZGcAbrB97SjpersRDI+zN6qwbhuF5S6mL7mT7q
	 qVEu2vaz+DKDA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 05/13] mm/damon/sysfs-schemes: use damon_nr_accesses_mvsum() for damo regions
Date: Fri, 19 Jun 2026 12:55:20 -0700
Message-ID: <20260619195521.35143-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619194750.B30821F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Jun 2026 19:47:50 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Calling `damon_nr_accesses_mvsum()` triggers a division by zero kernel panic when `aggr_interval` and `sample_interval` are configured to 0.

I will fix this in the next revision.

> - [Medium] Integer overflow in `damon_nr_accesses_mvsum()` on 32-bit architectures when `window_len` is large.

I will ignore this until a user claims this as an issue.

For more details: https://lore.kernel.org/20260619195232.26053-1-sj@kernel.org


Thanks,
SJ

[...]
