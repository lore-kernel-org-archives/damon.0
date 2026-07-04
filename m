Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCD196C7C
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783193905; cv=none; b=e3DNiCyWEp5MsdUnZlbTzxp4qYp0BMljkD9OqbGkHqO07qhcDmnic1tZnZrmxgsEouc4kW98UVAwexdy5hG65Fa7Lq/cTzDYvaF4SVmBwB6NTBAmc74LWgHuqs2y+Lb5QelqEmDWJusr2wVAfMYEMkRNMZJmqWgn985fLEwGRCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783193905; c=relaxed/simple;
	bh=AbjgAX3R0mNFky1XgFYQmnBuxuja1q9e3sadGV7AcMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+T/5CFf1PficHk0169qRmZzCRWUlsVTB9RvZBX44vmzaXJIpus28BCow2dVnseNC4Z/YQREihKltRcwtgvqfTeG3vfo2YfXo1PuY+9IESh2tduqOO9VOyZ8jRSmRSWSTvygzhJnKUSjsWjTvkUC+e6yderOlLUEpOR3cUxAeBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N87eyu7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N87eyu7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB1F1F000E9;
	Sat,  4 Jul 2026 19:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783193904;
	bh=AbjgAX3R0mNFky1XgFYQmnBuxuja1q9e3sadGV7AcMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N87eyu7ZILjmeHcqsd7+/uqm2QdOg5GMH+ci5h24SJqCf/8fotosvDtZdy4R2W3pi
	 Io1pMQmZvwHsfclXcyAiu+noVNjvGoYSDg8Wik2ixqWfrzsqCH06kwGqpZyGU9AQ1S
	 SXNGHwlmo5r+MnQm1iEKAD2u84iAogBnaCuGk4uVXp5++wJROY9K9vtltmIpWy1eoV
	 ifNTCic+0XBkgYt/WdfOuDxdcDRv7sJX3qTztjQeq6iP5ZhK+8FTeFYehF/CLq4Kzo
	 6S5SAscjpyDwr5wp9W9k93Bg2OPg2+0j4eciX+OQcb2UXNfLMdKnQPHWAqPTZMFvdt
	 zwEUpJcEcS8Tg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 10/11] samples/damon/wsse: do not stop ctx for damon_call() failure
Date: Sat,  4 Jul 2026 12:38:14 -0700
Message-ID: <20260704193815.1491-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704183159.E0D791F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 04 Jul 2026 18:31:59 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] A self-deadlock occurs in `damon_start()` if a subsequent context fails to start.

I will fix damon_start() patch in the next version.


Thanks,
SJ

[...]
