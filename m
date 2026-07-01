Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F7025B0B8;
	Wed,  1 Jul 2026 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913954; cv=none; b=tl2L4K1JcFNl0d7G9tIr7URoU6i3wKzDBAQk6hRxt93auquBRLMLp4Al5fkt+VdOGM4088MFDeA0vPDsea7rcnReL0ZYszoY5Id2FGK0Di+H5hA3E3pR+x0XgcQjfOO7et8wHqI3D+++Zovp42I/B4GpFPiGkelrTDPrYO9xSog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913954; c=relaxed/simple;
	bh=/fnl8WkEpVVgiLor8TqCRgSkBzZUvjdPR1vaL+tkTNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+RU/8TWy6s55YjOMkUMvBk908jFsLqFe4F8EFaOdqscMDdwvhQFYtrL2Uz6wY1X3UnPFaezG15nNu6uR3i3imtYfhssygihck0t+VeqEXOYXnti+G5+RC8GiSHrcaAFe/QdYwFI+5Jgi+M3U+I5npTG7IKuw9MGxqagZhUuL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICKU/rwX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICKU/rwX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EDB1F000E9;
	Wed,  1 Jul 2026 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782913953;
	bh=+at3T66B8FFjiwV+efoDLf0oTrOtgBnk1d6ck6Y4yMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ICKU/rwXY7DwkHITW7EMOoaGekRc1WyhuV5kJ0PG1c1/xLDWoHsjSC+42yZxut8NF
	 l/C1PSWibS76Kz5ziVH/A/7m77ocXbhbr7jhv/tYxUJdONs4MvfFaGDv8tMiNBzfpm
	 2Iel3q+VrqRLDymy5zYK7r4YjDeUJTxhqR4MsIDHypt0F4Lw82jcJ4ZumiUb42bcwv
	 N2qHVv5UcBliLT+jZfZc80R0s/YLrq6r0Hyc291fr+GoKrmnxkJwn9Cso0Di+5wFau
	 l0oR6W1mE+TNbuQHQOOgE/SWsYWQU1RJ7wICAgTgMWvujVttpQQjAJrO0xPagZpcsu
	 7kwlqjRTJniJg==
From: SJ Park <sj@kernel.org>
To: wang lian <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gutierrez.asier@huawei-partners.com,
	daichaobing@sangfor.com.cn,
	lianux.wang@processmission.com
Subject: Re: [PATCH v2 0/5] mm/damon: add mTHP collapse and split actions
Date: Wed,  1 Jul 2026 06:52:19 -0700
Message-ID: <20260701135220.93697-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701114716.56503-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the first version of this series that has dropped the RFC tag.  From
the next time, please reset the version number when you drop RFC.  E.g.,

    RFC PATCH -> RFC PATCH v2 -> RFC PATCH v3 -> PATCH v1 -> PATCH v2

Also, droppping RFC means you think this patch is ready to be merged as-is.  It
is important because the level of review should also be different for RFC and
non-RFC patches.  I'm unsure if this is your intention or you just mistakenly
dropped the tag, because I was expecting RFC v2 for this series.  Could you
please clarify?

I will hold review of this series before the answer to the above question is
clear.


Thanks,
SJ

[...]
