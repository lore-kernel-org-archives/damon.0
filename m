Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01625E800;
	Wed, 26 Feb 2025 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740610568; cv=none; b=ozG6azRZ1Z3pNBd7gIVCV8pS8rxx3PNjvgVnTBg8dSaVewIBBoiCK7sw1uyCDc6U1SeKDkW2JMw66wWUW99FOOzYWVIYmPg21BckH7ZG+yaNU+qX0BiXCETG5FplbRbhxDgt10MhI/x4glc4Hst77DpwjDjm1cgrQJ1OvWbLE4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740610568; c=relaxed/simple;
	bh=4xX+5Q+i9bj2ITh4m4EA0L/WP2gPeWuVn7rsEiHtns4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TaljPqNisAwLtnaEkIzdvYrkIE59FBFsPioN8K/U4JRr0vtW8pggDj7x2OdZZEF/mTuYg9LBgzk1DYgDdpx/e+8aqi4eXgzGoAvQkqPLBNIeWv4ukOfxAXDlez3z1QeZmZnMg60CZ6VamEg+EM83+J5WltIKamOR8QwuBcLu7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD0nGhv6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD0nGhv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30FAC4CEEC;
	Wed, 26 Feb 2025 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740610568;
	bh=4xX+5Q+i9bj2ITh4m4EA0L/WP2gPeWuVn7rsEiHtns4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OD0nGhv6cKgG3nykVETH8u6N9Oki+HvJE3OWzCkKj+++uPTWP+xmWjB7SFhlnGqb6
	 qRe0unCrzF/jtZ+GEPwA6m8bj+jH1vpO+l+avgoJFM9NELQsoUJdnvivkvhmhfk48P
	 QaHopmIsv5V8/KM+6thqbYpW/jnwYK1gt9d9xbaZadJowESTvEN1Bvql7WA+BgnHDM
	 OhpZb/FlgaYvEZGfUPI/GLOSXcFUAb16PTtHWq0uTvXJ2tRbuPG7C9ya/jaWBG3an2
	 H1ND/c5Fj+Xt2ijZhdTXzndXUgK1t+WjsVnVwB5nzBhABOsdmROc5Fe2yX3VNK6lOe
	 +H+Yr52NZdsWg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	bus710 <bus710@gmail.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] samples/damon: a typo in the kconfig - sameple
Date: Wed, 26 Feb 2025 14:56:05 -0800
Message-Id: <20250226225605.2000-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226133703.3c9775c9e50e198abc9b9f6e@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 26 Feb 2025 13:37:03 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 26 Feb 2025 10:42:04 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > From: bus710 <bus710@gmail.com>
> 
> Full names are preferred, please.  Actually I think it's "required".

Thank you for letting me clearly know this.  I'll request full names to DAMON
patch authors from next time.

bus710, we could still update the patch before it is merged into the mainline.
If you could, please let us know your full name and if we can update the patch
with that.

> 
> I'll apply it anyway due to the patch's minor nature, thanks.

I agree this is a simple enough patch that the name doesn't really matter.
Thank you Andrew :)


Thanks,
SJ
