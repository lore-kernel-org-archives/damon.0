Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10B91C1F0C
	for <damon@lists.linux.dev>; Mon, 13 Jan 2025 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796461; cv=none; b=CG5fyKqKazG58jcaymr13r9rcY1yFJiT428I4cHXuDKX7u8EQFLEzD6H3V+WuznWiqRiNrev/eYKUNN68xMWCDuJEtD6tdNTOFf3YCRcrBFFrUUrJcG5FFlC3UrudSdmNPk1/tSHdxXT+Qk1mMN8wKxvMMP7HyvTVLpO7VdfGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796461; c=relaxed/simple;
	bh=d+DjD00BipS5sMWSFIdPnC57/pOPscGGe7GrymO7ksM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5cGWqpTl7U4v4FfJfrZIQ8AMsZyz/a7KgRc3/pGy3GI81Shpsgdh4cGnMO5fi9VREK9JsAysqJfVJh9+vPt0TN0gaozK0rqNt8EXpi8tWf/Fn9U/5w1RuYOr3zOCdcOWt1CGF+/znDEzw4lw0gug7K96mbVVpGtLBbCa3/htgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k69pYvMO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k69pYvMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4A2C4CED6;
	Mon, 13 Jan 2025 19:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736796461;
	bh=d+DjD00BipS5sMWSFIdPnC57/pOPscGGe7GrymO7ksM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k69pYvMOzsrsmR4jLapNJ5v4CeoZX4SiXjMJhQEUH+Qd3SuDCphRWhCc8no7lf2wv
	 MT0M62d9y8M1lVmy+wJAlCfVd7i2yx8d5JqjgxcNmErtfb/Hpk36DLqNBqMMeTqkwy
	 xme/o4kzc5vvYchHn1tfJFWi3NKDxiIZxgayftQhQ3oK3xsXhpOBgAt6bgW5BvgUXH
	 m9JQpZZcFT05fY9YIw04oHbAtp1RZ/zrBnF0hC+3S2jH3ilDFF1M99qXrMwcue2ihF
	 RCpaTgzGgeqXeIqHb73ODX8161eCMsAADD/3l4zoHb/TeTW0mXOHzAKMjWH/BcMP/V
	 IrTzrx85T9gvw==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [v2] mm/damon/paddr: increment pa_stat damon address range by folio size
Date: Mon, 13 Jan 2025 11:27:38 -0800
Message-Id: <20250113192738.23408-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113190738.1156381-1-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 Jan 2025 19:07:38 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> This is to avoid going through all the pages in a folio.
> For folio_size > PAGE_SIZE, damon_get_folio will return NULL
> for tail pages, so the for loop in those instances will be a
> nop. Have a more efficient loop by just incrementing the
> address by folio_size.

Thank you for this nice patch, Usama!

> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
