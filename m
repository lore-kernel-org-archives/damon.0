Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188814ADD9C;
	Wed,  6 May 2026 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778087276; cv=none; b=olx03/JSFkV7DZcdu7/4SEaqDsszjK3P8KqexriFhvyej8KtYtSHb+Il1TXkl/5gE2rigUdU/07WEGgwhlbFWHZXSW/qaVTMJ2kk0lyf0a6uMEe+lqu49j3mjSN3/T8BbKBK1AOgzhPLq/B1/vXLU/pAXYLPL5x9zZF+1aRyPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778087276; c=relaxed/simple;
	bh=+0LrTCM1q5pRPs233Br9+vpmc8ij03vv4TyteHj0Org=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+MYOpG/gvYAJHc/U0n+iUl6RVmdQU6dafSQ6ZQEAUDYy2R17e56lsFddXoEkSK1/uSDnT+CJ/QLSeTTNYg4bVJmUhrbVo6Fwo88xkcyDVLsG/ughlENVIUHQrwNp7GGhgolKsv3l7AxCgFz4e4xcfXgJPTEeyIniKecAO+W/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAQouR/L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAQouR/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E615CC2BCB8;
	Wed,  6 May 2026 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778087274;
	bh=+0LrTCM1q5pRPs233Br9+vpmc8ij03vv4TyteHj0Org=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FAQouR/LQsRBkeo+uk40wP1EPH2xlzx8AmIfyExgkguDNfpZN651Tl70YXHVUaoMe
	 OO9rehcTElIhWOZEgPz1MCk0sfL45tg8witfe4ouy0Qf4dvKB3fF4fQ5TrDAk6lesY
	 OBZvi0WEdF8Jqpv0FOGeFfry0tQB+hXNDbebpEV7f0R4XNHhD11WcoNpP5IRHLjVeI
	 /X+pKt3/v87TZTVkblyr5rH0gz7KhbceI6YmC0JNLSFhPVn3gkRKtdwpwkYyojj5nH
	 mp/LCZ1T+SXqrZwKTt604htee0Et+qoHnvOWp+3PwnK58RrDDfBI/3SmwB2EzYtkjv
	 MVtc9cLw35t7Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Data Access-aware Transparent Hugepages
Date: Wed,  6 May 2026 10:07:49 -0700
Message-ID: <20260506170750.10764-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260211050729.69719-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


The slides for this topic is available at [1].

[1] https://lore.kernel.org/linux-mm/20260504070208.7106-1-sj@kernel.org/


Thanks,
SJ

[...]
