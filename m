Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBF54A32;
	Sat, 21 Feb 2026 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771697283; cv=none; b=P3ZSkFdPjjft+T4VugHRVM9x6C2jDQiv/b/LSD6q0iyY2wHwAWz4YzVG5hCvfDjKvmTAMTV073ldt/X+ywK2fSyB5jMoxdWAwUqUr40eVcLJLyG2W3J6dNzeFLIarY/9+IEssGTtRevNBomVo9HB1EmK5NS03ITwnqwg5kl5Si4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771697283; c=relaxed/simple;
	bh=BPzQx21V/we35w66JCHEVqoFg7dX4MoY+Ku4InKpaBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cx+lDY/J6n9xSFv5YSZd2JMdyFM3qEhBc/jxs71REp90ImJa+9Az2G24GUVLD+nMipWPIrcNUtEToPxWChQnJzaWxbFrqbgy+NOd82D0ysCr7krXGJb5Vm3PLnRrSBsvPZ7Cb/BErV4EmlVzBGlWNM4qY7b/dyjM0XNvdZiS1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdZcYRDF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdZcYRDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EAEC4CEF7;
	Sat, 21 Feb 2026 18:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771697282;
	bh=BPzQx21V/we35w66JCHEVqoFg7dX4MoY+Ku4InKpaBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdZcYRDFdDDod4Ylxzd6FUP3KNcZ3/n8AypcPv1RyjZ+W4wfw/KfVd84c/VtTvAau
	 tUCEDNnzKueD+mOzVIJl/E7JxGAiyu0UJFHY0TwKsEbl1nEHYPDvLkAAfh5hY3/T2d
	 yINBPVtZceE7vfBeC8GVRA84vKh5uDzNoDjym5BS88navj4YHY/HyI/9hBD3e4BYhW
	 pJkT5czeZfNdWg271WExdWGmy05pwyU3mmR+QJyDmQ9CuekLJUgYWiq/8WSglI5yV4
	 s3greZkZ/hRatkmAskwhW+0vQZRtmgeWf4RdsusLlizFUBWT69yh5DpJMZbhXiS0rO
	 TKxEWT6W7jwRg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [RFC PATCH 1/3] mm/damon/core: split regions for min_nr_regions at beginning
Date: Sat, 21 Feb 2026 10:07:54 -0800
Message-ID: <20260221180755.10505-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260220151301.58159-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Feb 2026 07:13:01 -0800 SeongJae Park <sj@kernel.org> wrote:

[...]
> If nobodys finds some problems on this, I will post RFC v2 of this after
> squashing the above diff into this patch, probably within this weekend.

The RFC v2 is posted:
https://lore.kernel.org/20260221180341.10313-1-sj@kernel.org


Thanks,
SJ

[...]
