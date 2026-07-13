Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05743CED8
	for <damon@lists.linux.dev>; Mon, 13 Jul 2026 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954683; cv=none; b=JIVkNM0tjNjVrxgDn3YX8A3yjTLtsXqez6epgvw1zdyQtwl6qNQD2ESv5JSbj2VxVhTjSA5bSI69Dl8NHhz6r2479NhDDz2sTFIMuEVw0tM7rcxj+/71gUhIse846UtsgoL9/tv2ceFzOwSCgleW9HvtrD8Uhs9hBTg/Mcp3OA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954683; c=relaxed/simple;
	bh=+N+ovGCZ/CpD7PcvlBGmZhzz0VVOwtWFR4iOlX4ozZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGtvoYgN/YL9QFapQEyqN34dv8sj2Zk+lZo1qSEyWSsaMSYWB8pps/kYpBpwwAvY2mwChpPuc76FcIHUcOGNM6tccOEYq1f1pyBUlYwbTsJSxZ64ADytB98mk+1mbk6HdDQBMkwT1/EfgvadOnJ07n7FWKMRf3WVYofX6PgUvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLnWhb2h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLnWhb2h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9631F00A3A;
	Mon, 13 Jul 2026 14:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783954680;
	bh=O9IHhEysy4K1XDV8ILNBXnZfEoRXPcuGiIJwTEJG9A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jLnWhb2hvjgVavg7uG3FOj//cEvdlPm9+N62yZemwjayc9yLYWpEQwlw7tNYj/LCW
	 C0VPmrhjDT5Y8xHPCFKq60aQw4Dk+mYEejoj/21kqhqWcMv/VJjWQOsSFPzLlfYLbU
	 kah9J5CLOAgXqbx4iSZksfZKFsxi0MMBWw22q04WleVqmUjghadKJ72ZAGandIFHXF
	 vtyRKU5b8zxtBIBGWztGxd7NtACMf7qBsoIXA9ahsEPM8oMljuoSzOSnAvIC5rBdPw
	 5ftJLutSlS8JtS4NgWI+VpSi+M/qDsSm7WjiVh6Qv7pUWk/AtorsxNbvdLXfpxjNGI
	 mSkALU5/cchvw==
From: SJ Park <sj@kernel.org>
To: Harish CS <harish.cs.ss24@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Regarding additional fixes for on node memcg quota metric issues
Date: Mon, 13 Jul 2026 07:57:51 -0700
Message-ID: <20260713145752.40192-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAGjpMsSMG2kaEWfP+fFw1PN13Adj_t81kzh-SDppnWQXRw88Yg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Harish,

On Mon, 13 Jul 2026 12:32:17 +0530 Harish CS <harish.cs.ss24@gmail.com> wrote:

> Hello SJ,
> 
> I came across the Sashiko review of damos_get_node_memcg_used_bp(), which
> identified possible unsigned underflow, division-by-zero, and 32-bit
> overflow issues in thenode_memcg_{used,free}_bp quota metric calculation.
> I saw your response that you planned to work on these findings separately.
> I am a newcomer to DAMON and upstream  kernel development, and I am
> interested in contributing to this work. Are these issues still open,and
> would it be okay for me to work on them?

Yes, please feel free to work on it and send patches! :)

> 
> And I would appreciate some initial direction on the approach on validating
> the fix.

I don't think it is easy to be tested.  Many Sashiko-found bugs are
theoretically possible but not very common.

Maybe you could run DAMON selftests, kunit tests and/or even DAMON test suite
for correctness [1] and ensure your change doesn't regress at least existing
tests?

> 
> Please let me know whether this would be a reasonable starting point or if
> you would recommend a different approach.

I think this is a reasonable starting point.  Thank you for considering
contribution!

> 
> Parent Bug Discussion:
> https://lore.kernel.org/20260329153425.47097-1-sj@kernel.org/
> Thank you for your time and guidance.
> 
> Regards,
> Harish C S
> 

[1] https://github.com/damonitor/damon-tests/tree/master/corr


Thanks,
SJ
