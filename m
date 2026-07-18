Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB818175A6A;
	Sat, 18 Jul 2026 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784336821; cv=none; b=UNZYcdFh+u4tq815Xa0JEzix+HaE/myUzjFjJU8wvIAo9qAss4FDJQCqf+yh6DFIGQpcrLYBNfs2Uh4wVOfATGsCyPxSseWPo5sOS9ltbE9UUq8prwxV8hCYeAzdoEXfep8aN1NGnbXUs5VYrFQPIYfi5OL/uBrAtloslL4iQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784336821; c=relaxed/simple;
	bh=YG0mdfG0BXh7KKFtEcFpLLkklS2Mwv5JgqWR6Uh6oVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfdT5mOp2rmNSkkuRn+9tO6qdVHzTfB0BG82nW+PXNl1O42AyJD7Y4hCmGXlnIZrcMbS99/GlSgP6DllaHBKWYSGVXjkYDA5r42NwXntPXAgZUVouFiszye9Tx0tQZ9ZpWpPzj30AlEPNRYs01QvAy6KbRuN9pvxA5Jj1CoFSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izo+5/qw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izo+5/qw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB611F000E9;
	Sat, 18 Jul 2026 01:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784336820;
	bh=vk91zqmkPVUe7yFQkVR0enbUPDMSCZSzWC7GhPFYNJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Izo+5/qwMP0EU+kHudTvtcAvadEZX9z64+UjS6Fe3fAJfIZJumtZyi6troLLmGJr1
	 /T5Vut5/Q5L0T3j9lKhtHoAY6E8KDAEyezaMSp4gtLxrdjGBGZKhxr+UhdoR0DXhAn
	 UXFyymyuJmr4M8tlUi5TVS8Na5LfyYbLvx0F2AZ4R/nOb/3xdI7mIydmU+0nZXhY4C
	 ZxGNCKMU5KXMXQL4XMldQ5HRpswHQNWhZ3Fh0WGXfzkG5g2FndcRv/Vrtc8SN6cct1
	 wFJRYDefvfJ9HPvqX5AiZIydZJLQ42iH9fd8/zwHonnCRqutZJeywVfylNMgg7tHh9
	 zlZ+0X7ha0w/w==
From: SJ Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/ops-common: remove redundant local variable in damon_migrate_folio_list()
Date: Fri, 17 Jul 2026 18:06:52 -0700
Message-ID: <20260718010652.92773-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718002125.637104-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Enze,

get_maintainer.pl suggests to Cc linux-kernel@vger.kernel.org too.  Adding it
to Cc list.

On Sat, 18 Jul 2026 08:21:25 +0800 Enze Li <lienze@kylinos.cn> wrote:

> In damon_migrate_folio_list(), we're redeclaring folio inside the first
> while loop, but it just shadows the outer one.  Since the second loop
> uses the outer folio anyway, the inner declaration is pointless.
> 
> Remove it to consistently reuse the same variable throughout the
> function and improve readability.

Nice catch!

> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
