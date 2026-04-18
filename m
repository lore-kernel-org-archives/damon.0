Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D0E242D84
	for <damon@lists.linux.dev>; Sat, 18 Apr 2026 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776526824; cv=none; b=EZG/7am3WJyJb95BmFxbulPXimWnI63p/MIshgdckGrPzNp9W1dhBeBLmFHaPdx+Ts08vcfhmtJ3BRwq+avsnD2P+BEVBn0wyB0DHHxIRiSj0TMZSDGiBkgjLoAQUVPm6zJ7dXDcyVC1j06Ikic/AjoSCp7cExAMLF2nl5S0La8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776526824; c=relaxed/simple;
	bh=C41ld2BrjZL9YD/GCZx/Rwax2QPbfS+wuq62Z/7uvNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mk9ygUKOhECddzgyODUSOUofQ4MzLSoibLPXLaSVi+HgbnFAmDvXWdDlE/OnXRHAfPUsEDec2boznUpgMe7lKZe5nPhCJQNkOy/WjU+RelgO4CBrnKrgYJySAzL0UiSYn3mLjV5jsldn2Ry06oG5WEvssPlieuqlMVxOZErd+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZShCRKsP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZShCRKsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEE1C19424;
	Sat, 18 Apr 2026 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776526823;
	bh=C41ld2BrjZL9YD/GCZx/Rwax2QPbfS+wuq62Z/7uvNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZShCRKsPDkQ5ay1q0NsSDEIenl5jaL0+GgwiNXBF/pb6A38E7mba0E7iX7BtgD9Zw
	 hXNbENqaa8KDhCZsdmkUyidQgoVcs5SgE7uW7oEkFqoGvoDncNcoewFeAsU3IlVrgx
	 D3AQe5nY5GIxoUnXO4zlTMbiAvmE7dWOV6ZZUR38FpurNm9daCkv9hYC0sTQOCKHrX
	 Ss/jiISfRhfTRRmgporLRSza0u6X1GxTc4urBs1Q2HOlR/oB2Pl0tbVUpDW0RZauRb
	 WahBUlwx4YmNF9kq5YSxEp6LGNP62ZDlKFDWxII79wmLtffYL3aqsZKXD6pQEGM5u7
	 1Y7uNp8YHL6uQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 3/3] mm/damon/stat: detect and use fresh enabled value
Date: Sat, 18 Apr 2026 08:40:15 -0700
Message-ID: <20260418154016.1057-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418055417.1399AC19424@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 18 Apr 2026 05:54:16 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [Medium] Leaking damon_stat_context when explicitly disabling DAMON_STAT after an unexpected kdamond termination.

This is wrong.  I replied the detail [1] in the previous version.

[1] https://lore.kernel.org/20260417000308.58975-1-sj@kernel.org


Thanks,
SJ

[...]
