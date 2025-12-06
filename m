Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF80DEEB3
	for <damon@lists.linux.dev>; Sat,  6 Dec 2025 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764985818; cv=none; b=QdNbd4rQW/hKsDqOsURe4CHUsWsqb3Gi8nUODoKE8ypst4P2t5iWoF/q37f2IyFyRCArwwL2bPVIQm3wtpOoLuz2VSBuSVRQMsEGRXujUwouy6YZUaCzmLrbuK+Yqu7ZhXq7AN2aNMIvfO9BPIXzmVGKSLlxis4YU+9Qu06vkBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764985818; c=relaxed/simple;
	bh=in0qOOSwH8FtqkBiehP6uo5dV7ebZ+JdQOSUFNW/f2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aS2KsaXJRxN+tWvYVgguK6kHpDaiPNBNLcWKd/UiZYFSUkqXqVbJRRLG+Qkp4pCpRq0EOsOQd8X52JhGcLnK9SZ647KZ3mHlin4U0jXdzMEW1k2HNQ0wuIvy1BOFe84EQMbWq58UNfOGxBz+XgxgdwmKuOQu8l5wIYQa/QLJi10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2LVbotm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2LVbotm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F43BC4CEF1;
	Sat,  6 Dec 2025 01:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764985818;
	bh=in0qOOSwH8FtqkBiehP6uo5dV7ebZ+JdQOSUFNW/f2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2LVbotmeW7bX2yMDAAtRgWtuVUYdisjNhKqgiHW4KGSPhy1fBfq2sC2dF74d8dC5
	 jUSj5xI2VzLUnKhbGS2U67PiOyX67Ut5Y371RGCIr9TdGUTJr/drglqz4BKDpdHEFG
	 NxmyY59f07yY/YmyHbp5Ka7IISkhpl5xSJubakZ9yww7nZb8uUsoqrtKr0lCXn+dho
	 PfB68H9nrDXv9lLxkn66NW5Rj1U7713kf6lRznH6r51VA+tguE4Vyu5uTHLhEFxk1z
	 P0Nsp0nKLk6f+httVUR2BHOceg8Fg/zI5Ellh/1p2LDeLj8pY4Gsn5Obn9EGMXlOvb
	 ljhzJZQ75auDw==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	lienze@kylinos.cn
Subject: Re: [PATCH v3] mm/damon/stat: deduplicate intervals_goal setup in damon_stat_build_ctx()
Date: Fri,  5 Dec 2025 17:50:10 -0800
Message-ID: <20251206015010.47826-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251206011716.7185-1-rgbi3307@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  6 Dec 2025 10:17:13 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> The damon_stat_build_ctx() function sets the values of intervals_goal
> structure members.  These values are applied to damon_ctx in
> damon_set_attrs().  However, It is resetting the values that were already
> applied previously to the same values.  I suggest removing this code as it
> constitutes duplicate execution.
> 
> Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> Reviewed-by: Enze Li <lienze@kylinos.cn>

I show Enze did suggest changes [1] to v2 of this patch.  But I don't show Enze
gave Reviewed-by: tag to the patch.  Am I missing something?

[1] https://lore.kernel.org/875xal44lf.fsf@

> Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
