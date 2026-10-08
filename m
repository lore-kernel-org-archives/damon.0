Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218149A3D8
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791462757; cv=none; b=tvd3e9mAW3/LhvxsNAGIgosds5pNOyhS42URXM5u+dlSy/GQwyuwUXih3ET/h0pE4YNkWjhYJ0vjXkjQW62XwvGrGFl5+4tNLsnMxU6yjjQp73v7/k8FAKv0xQRc6i4sDY1fYKvOMrn31srpz/g/2oOcbrFSMUbFJ757YihdF2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791462757; c=relaxed/simple;
	bh=OiFgI3T2pqzWitrnjWdHfkQBZKvRsXABil0ytjMP7WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chhH71wBvnPzp45PgfhLEY9MIgTG0fzuHaSwIC2WPc6JkqGFW3s6Rdw2Bsi/tVykhkj8EObzzgwEOJJ+gh9o9H9/6DR+s74px1K+pozpujW28XZ1+/u9f1hcMPpmZbaCdQJw6OkaC8gMfYdZha25YpOZvfzq42Y4/46AXPGqK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKS2Bfgl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKS2Bfgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4B31F000FF;
	Thu,  8 Oct 2026 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791462755;
	bh=nmteuJ78jqh1Ln7c8dSnhU/GJ5JSXutSDUniST+kAJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lKS2Bfgl8TwwcykKDSmb+5YrNh6rvMBmhOv4vWhPSkI1kFLeonN5sMHO5pUTrwLrB
	 Ol7GYigQhKEVKTF5XWfANk1ySD4Qzs6nNZoZ9t5Dgv96ywPbplLlVkm5tS8HD3XxNS
	 AwNxWG+f3nyYBPT+1U4m4vntgW3aMclTGegEanpZ9CcAuWe2EcBoB/D+L9LxeUYCEJ
	 jWrMgVTVpPq55nODE36G0I9J7/qgK5mjxZqLqphiJ92UbfKyX3wJQK1eWZj8RRQR4o
	 TqxGrpE72iqbbcq8AZgphrg3KaMIHXgcdemQiUQ5C93yMrnez6eizrcc93dY5c2FLE
	 J0tR4zPfisA1Q==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC] mm/damon/damo: saving damon sysfs configuration
Date: Thu,  8 Oct 2026 05:32:31 -0700
Message-ID: <20261008123231.45171-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008120916.4612-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liew,

On Thu,  8 Oct 2026 20:09:05 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SJ,
> 
> Just a reminder, I think you might have missed the question I asked.

Could you please clarify what is the question that is not yet answered?


Thanks,
SJ
