Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EEE28BAB9;
	Thu, 12 Feb 2026 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877674; cv=none; b=ay0TcfaMbqGuxzVU093GQyKMAI9XiPRJatlH2IgfMkxrfwVPrHVO5waHEh9vihSEugIw2T8HQPoUHF5JESHB7eFeaQcxm8kDOiF+JaRB9kxe4UMBKB6KwQYizL4mx/QzASmcX2km8xxXj70r9StYzHJkLctBXhzf639ot7sKe0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877674; c=relaxed/simple;
	bh=xRTSeaOTTgMyO66UkzQ4P/Can2kfHXf/45m+O2x5X48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHO8kKOkIoq+5tzWLyrOiemicE2SIfmrpTHDcxyDpud+aXHgA1xXmcKgqbviXVWELRQYML2PLiQyJ8Ak5sDROxYubVkFBE2V8DNZzJKRIa4OmN3CyXHiF5rsT2oTdoYEHfvRDP3NisBwp5H1xooyCdp/T6G400+8tz30Bm/7atM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTrL55GO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTrL55GO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7D1C4CEF7;
	Thu, 12 Feb 2026 06:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770877674;
	bh=xRTSeaOTTgMyO66UkzQ4P/Can2kfHXf/45m+O2x5X48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTrL55GOA6WSIMk2LGZGpq/envakKOJR8mq6Jzjt0WuoU3AZQTCa3ORPRNdhsn248
	 0ad8cHGlfx/I//RAd7PemtOcW/kffXjKkGbrGgmgIANhWMfvE06q9/69s2xU6AXi6R
	 xxcKW1/GRQ37wsabZkLpbBCNk8mmOCVpnGuWvvIAgjvqpxVVm8l5RB6S/uZZ5wzQYx
	 nV2zlQ5T5GNGFKDMvTJBBN81UFAmKsxQE9JHGVTFvN6exgAhvbxwYlLyAdPWqsleQf
	 rSRo3Q9OFX5Y8s5pXxzInZYyip1fBaoFxhP7UELoSdUaiGeWuUSh2P5+yXTpxlpEOc
	 fDeyilgDKIhgQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [RFC PATCH 0/5] mm/damon: Add node_sys_bp quota goal metric for PA-based migration control
Date: Wed, 11 Feb 2026 22:27:49 -0800
Message-ID: <20260212062750.70451-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128012539.72119-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 27 Jan 2026 17:25:37 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 27 Jan 2026 10:52:53 -0800 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> 
[...]
> > An immediate-stop feature could still be useful for the broader community.
> 
> Thank you for the feedback.  I will take more time on thinking about how to
> implement this.

I just posted an RFC patch series for this:
https://lore.kernel.org/20260212062314.69961-1-sj@kernel.org


Thanks,
SJ

[...]
