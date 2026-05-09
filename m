Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145FA1EB5C2;
	Sat,  9 May 2026 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778339974; cv=none; b=l+ZZL0WfVD0Q6sj1TbAI1LwAYJfYfPZSsUUc92bUzE/6WcjrnvikXk5aaqrY1mu6Yl3iDIWp2iaPGJTKSVr/KrtgHAp/pwjgpt/7E2qMFvFlHB6AA0gulHkD2ryuzg7L/N3HTCCyW4ySyWFQ3QtvLdA5tA4S9BC2Q8rLJmkEX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778339974; c=relaxed/simple;
	bh=z08Z4iCa58yBav2NNK7mz/6fzDqLoDFGqmmR0N7MAtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDcgC0EAQAVG+7cdLRzEGFfIG4BgeyA5tmyuMSEofI4mwqwHEYlQWQiePQz9N5niOXpGhgCXUBbqoR186noXobC22wFUcSGNSFqtYmwNO/5AuX3ui4wTD3YlmhzMvf1onE4knmuXfpYga+ewi8Rh0jaYqgeDeL29ZnmH28DPhSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKCkOZXx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKCkOZXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F23C2BCB2;
	Sat,  9 May 2026 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778339973;
	bh=z08Z4iCa58yBav2NNK7mz/6fzDqLoDFGqmmR0N7MAtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKCkOZXxaWD0W0OxzJ+agG+Dkk9/tBr0u0QMsJuYjhTJYnb0ceqz7K3IUXwoBFwU/
	 orBzVJWH9nFQHo5ENAUHvJQaeZRQlIr/pdkjcXf8ic4rboHM+RK5HFS0451b5oK8Lv
	 +VpmeyyZ3F4Ip413g5s7ugWSaoKfq07ZsUPwG+xkPd+e5k3AM9xttwGboPbLS7T7IY
	 Q4C5SoKlIZ7PF3trkm1wJmiC2TbdtiFLh/1a6zrcVIP20KlUZAXBzb0EP/fP/b6c0o
	 GillNad1AKR1m5gP4kChRuPyNynBxuff1Wyel8bAtifN35/2uelRbi3psf4xSGboBm
	 YrD/V34v1bt0A==
From: SeongJae Park <sj@kernel.org>
To: Yu Qin <qin.yuA@h3c.com>
Cc: SeongJae Park <sj@kernel.org>,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	damon@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix incorrect field name in damos_stat_after_apply_interval
Date: Sat,  9 May 2026 08:19:25 -0700
Message-ID: <20260509151926.119256-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260509034951.3757618-1-qin.yuA@h3c.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 9 May 2026 11:49:51 +0800 Yu Qin <qin.yuA@h3c.com> wrote:

> Fix the format string to use 'sz_applied' instead of 'sz_tried' to correctly
> represent the applied size.

Thank you for kindly fixing this, Yu!

However, same fix is already queued [1] for next merge window.  So
unfortunately we may not able to merge this patch.

Looking forward to your next patch, though!

[1] https://lore.kernel.org/mm-commits/20260426200250.BE164C2BCAF@smtp.kernel.org/


Thanks,
SJ

[...]
