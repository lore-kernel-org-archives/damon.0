Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7B15530B
	for <damon@lists.linux.dev>; Thu, 16 Jan 2025 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737053376; cv=none; b=EeyDRrZSnz+XffAlJG3ucTxheLSzqHbn5lFr+WImoxmrHaMgfOOKnyiB9xL4YV+kWg0nGhkqfB/AiN+VXYNQtanJki6oiO9Lym7mCdAYfZxP96xP3OI2SNv0Rs1NKpD7p6Ox9jVuUp2bSjsDEPmqT3jdUzyLzjtFpmaxCe4RQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737053376; c=relaxed/simple;
	bh=CXm4S2MDiHwKjRpXsJNEK55VTdnrEQSqkB5xqNC/6o4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HssXp9aIOBl34/u3M2XTGRhCW9WvWPclR+enhWdvjeXjB6RNeAQzjNSqLC1mEhEhQfJ1y6DyLZvxDDLoNin4ehQwzecxrKWHR8DOK3YSFxmBahV7uTeeKxANnouyDFdIyiv3wl6bEGwHWnUZjxs9BqWeuzkmlZsGVHpmIXBEDDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVc4MG4D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVc4MG4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D428AC4CED6;
	Thu, 16 Jan 2025 18:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737053376;
	bh=CXm4S2MDiHwKjRpXsJNEK55VTdnrEQSqkB5xqNC/6o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVc4MG4Dva/7uUdv7P6Vmf6wzdlSlfuXAbF4fbudSUCX3FEFTo9ZNmkBszcBrVfvZ
	 nYPHezZfzC8HIe/otV7XQJAUBzF/e1BNchD0BQcshcX6AGa/bsczfKAY4UJdITERjr
	 EwX2OkHqeqSTZb5qdoj/QucWjUMFlqhSwGvxvyoIaI2hjLLjklQV8kn8f5nBpV2fND
	 /oAYc+i4wxe0GGNqdlzpOMUQwcL1UdAIMKnamlokX4H4PC2NIZsk790eo0KitwNDDc
	 a4dHGQbp6bBkFqxS/4nw2kk1aqKnUefPwy01r1ov7z1gNi98ZJ5aP4slrcfsX2qdS4
	 7360ak0cNNaUA==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [v1 1/2] mm/damon: have damon_get_folio return folio even for tail pages
Date: Thu, 16 Jan 2025 10:49:32 -0800
Message-Id: <20250116184932.23409-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116144436.3947318-1-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 16 Jan 2025 14:44:35 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> This effectively adds support for large folios in damon for paddr,
> as damon_pa_mkold/young won't get a null folio from this function
> and won't ignore it, hence access will be checked and reported.
> This also means that larger folios will be considered for
> different DAMOS actions like pageout, prioritization and migration.
> As these DAMOS actions will consider larger folios, iterate through
> the region at folio_size and not PAGE_SIZE intervals.
> This should not have an affect on vaddr, as damon_young_pmd_entry
> considers pmd entries.

This patch will improve both accuracy of monitoring results and efficiency of
DAMOS for paddr use cases on THP-enabled systems.  Thank you Usama!

> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
