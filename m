Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D7382F10;
	Fri, 19 Jun 2026 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884772; cv=none; b=NXYAjQN2Qj6G+H2GTcYB0S2zZOcV7u+wXixGX0MD2Z+cdOPzEvn9fFaIe6m8HXCq8+AMI+7UEO2ZYaj6RIboMHgbz7S4gRWwbTE6KAqEtpOQZ8gW6hR2Qga6RRZ2xzCKNgrxgtgZCu2JVs76wYxAU8POE/oEvJ0Srl0v7XNbAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884772; c=relaxed/simple;
	bh=M3ylYdFga6zLiPhuvJDKBmNdgkK2TSAnMenPwx1Bo9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrXSqxPGxJMAASs3lYxxA2UdIJNXLjI9Wt4A1exIy+7/psFvXT+oMipJnS6/eBF/Kpa7kheVYLQCJST8GfYuoR3YWLbj6qoSMWkl0vbdVWQZVeOnuZJ31XrX5uj9S9Zck3w766XBoByq6ipqza90ZBgdFH6WqJPn4A52GJIq6Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzpLdfoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzpLdfoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570F81F000E9;
	Fri, 19 Jun 2026 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781884770;
	bh=w5RvRcw2meqklJnqkmu+HVWNIM7O8C9FRlJA2J68Y1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kzpLdfojBQvivOuVJaw39xtnvXRBtgCnT94eTds/Pj+vRFfIMZHexNsuZzIxJrtb6
	 fuvMaSTbUczNESBm50c+1q2ZLNXmt1IojMeOXrkmF2RZIhRWoPzQ/Vq1nSjL19Uk9i
	 HikQOTWs1M/cd/xcAiHTYBqkmKlxwPn3M91hDa8Ns9hFAS6QCdE7763q/YLSzlGoe4
	 Zi3HgCXudWZvesA3Df53ZmWzxc3vEm9BAqDaAcwM8EUad3U2/V9jDeByssUgiJJ8XP
	 +LIo/RrVnE4I8oFYPQfOn18J09HIGQT2EctHykU2piPf8CSc70xwZG3U50dm1I3FRV
	 e4mrfFSGWqjxA==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Fri, 19 Jun 2026 08:59:23 -0700
Message-ID: <20260619155924.11962-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619145821.2109933-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Asier,


Thank you for keep working on this.

But, I don't think you answered all my questions to the previous revision.
Correct me if I'm wrong.  If I'm not incorrect, could you please make sure all
comments are addressed before sending a new revision, from next time?  I'm
holding reviewing this revision until all my comments on the previous reevision
are addressed.


Thanks,
SJ

[...]
