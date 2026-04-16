Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B6175A7F
	for <damon@lists.linux.dev>; Thu, 16 Apr 2026 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298651; cv=none; b=dE99f7Lch3LOuvrGU0PFaU0yjVGuhpnsztD45iUNC/q5W4s+dUMaderTUpudAaI85J02fSRC8D6byYRgVOTcufdlQRyh0I2UizIa5VL1hPwxk21RP5WS8arLoXV6bZFNRMmu9VVuQF7wTJiEjqgA7U6IyezTfa54hd4QkFtFiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298651; c=relaxed/simple;
	bh=lCoebV5QS35oMFku9uLMsRapyWp/sLdsdBGqr5M38nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pB7S9AYYHW97AKJrVOEhG0JecO9wmnwCcbJZtGhZI+loL8Lc/jm0gTG/5mQfxLNEojmeNaN2wF/WZzTOkxbiL/Q1zZW7k9mt0IuVhbxhMFv2OeApyiwV5+v6844dGUUZDBzPncmbr9hAER0yHxVTyTTbgFmZ3Qea65QNZnjoyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP9yMaOP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP9yMaOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C54C19424;
	Thu, 16 Apr 2026 00:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776298651;
	bh=lCoebV5QS35oMFku9uLMsRapyWp/sLdsdBGqr5M38nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KP9yMaOPrmVnGg04j/SZiLLodKuEKQn7iWBDdAcnH+2i7RdiXeADwSoSyIBZO5L8L
	 T3MWsy+rZwico6w6iNl9ZySwMUGkT/vaLfboZ0JN0gY8uCGhYXc/K+8uLgBrt574pG
	 lO7z2ozNWNv++AkRqmmg6eGwhWW7GRDH07evzxj6GCM8SbwuOk0F6z7aG22V/DU656
	 r4JP2NcYEFnMq0iFWnhNlV2DnaF+JEOnQciVAfAaow9oe409OBMUWldcMCHM+WhzDt
	 o1AMtMpVvbdAR9uxULISYxE2jJzKAr2saH0mjb03p94HsNawNUcSUf6h+xj9FQiwbZ
	 s1d6iYFRs0QKg==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] mm/damon: reset thread status parameters upon kdamond termination
Date: Wed, 15 Apr 2026 17:17:27 -0700
Message-ID: <20260416001727.86548-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260413185249.5921-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Apr 2026 02:52:47 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
[...]
> 
>  mm/damon/lru_sort.c | 13 +++++++++++--
>  mm/damon/reclaim.c  | 13 +++++++++++--
>  2 files changed, 22 insertions(+), 4 deletions(-)

One more trivial comment.  Let's use 'mm/damon/reclaim,lru_sort:' for the
series subject prefix.


Thanks,
SJ

[...]
