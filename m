Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2F28A415;
	Fri, 20 Jun 2025 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435868; cv=none; b=q+6Nldt0Eijyfr4Qgio1tmbzZGLicMFdThOovLX4nMvtQAa+cAfkSUPGLY+eLYBQUzJAA80YYElVE+6E2H1c1PrC483wpvAhVEiUj71wlRYk6KuygUxdKUXh9LscyxTFvo9wvLAk+ce1O7AKVZWALctPTagot2KVYFWqdD9drEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435868; c=relaxed/simple;
	bh=cMsToKQra6SoEZ95WA5ciGsWf0ZfqId5fb1Qz7oO9DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YEKrI05J9oXMkAwbj9yehXCiqwSPCqbkjt+IwhhbLpQH9GB4FeDAzVQuHwfUnn0CZZVrKxcNpmctTe3470hbx072WTMv9J/M08Q5tPYT4DBqyFBTUYelHopqoSHW92Dr4OhaN1PDEpsBU6PZKiH+AvP72YIKE3aF4G0fqtUa55s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEDlYaNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEDlYaNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CB0C4CEE3;
	Fri, 20 Jun 2025 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750435868;
	bh=cMsToKQra6SoEZ95WA5ciGsWf0ZfqId5fb1Qz7oO9DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WEDlYaNvKP9R2dVWR7oICRpdxQzvkL5qnNUactE0pDORRyNS0fibiV0zkqcBaL7ck
	 hix2D8/avFGsT3dH38Jb1X5sOuyQhhs+3B6jRLGc04zlEIrbOgX9B1qPDyqrso//ce
	 m++niAIjlwJeT6Kkr1fkf3nFnf0OVpUq2pQnZFNdOSHQv+boWkWQ5S4YMVTgQ7B2A5
	 pB5EW4gGq1WOxJZ6Ii8FvheNMUhF+EGe5JPUq40bKJjSJdIN03EQLQ2DRUfwaplRYG
	 gNKha0txWR3TOKDh55QHKv7YX+0ZpDqwTV+oS0OEvfs5wyNfgTHtIHRdHP/UvdW52a
	 5uxGlX+gGT5Fw==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH] samples/damon: add parameters for node0 memory usage
Date: Fri, 20 Jun 2025 09:11:05 -0700
Message-Id: <20250620161105.44460-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620062951.1572-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 15:29:46 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

[...]
> Thanks for reviewing. As you said, this mtier sample module needs further 
> development for final version, like automatically detecting memory tiers and
> adding some useful knobs.

I believe such additional features could be useful sample that could help
people figure out how they could build real products.

> May I continue working on the mtier module? 

Yes, of course.  That would be awesome and helpful.


Thanks,
SJ

[...]
