Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51434A59
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275734; cv=none; b=kWBNBw1Movdfvzv0s2DxjK11di/NYBplxJQitFt5KLxDA+sPzpHIuyu+07tq943fB0pcE5mzlQBWoUTbWo5C0VhFmvmpCPEAgUeJVc8lMP9VuHRoU3R6cw/gzOlrorlrNvOL/KAwBmRreHzEiLtSl0BRL3UuEbbFGjdqnNv4l/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275734; c=relaxed/simple;
	bh=RjpDxLk9rU7OOSjXqNDUmgbPPvZ7Jn5hdcpGMM/hqqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLhCpQc/E+r7j7+GFU2bLj3asXnvB4chSFlv6LLwQW1PDZN9uA0Jvg7NyxiQqm65SJuYwuhTKmydtpRIXVmWekwBa7BljkohHecVq6ZxLNI+aaLrgGpyoyfA4bc6YXJDCcNdA6kEo2pOFtOeeUSRDUNe9AMJNaaR37veL0VvXy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Je6IqAG6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je6IqAG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FC5C2BC9E;
	Mon, 23 Mar 2026 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774275734;
	bh=RjpDxLk9rU7OOSjXqNDUmgbPPvZ7Jn5hdcpGMM/hqqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Je6IqAG6WUMLRcNbhLvOyLKM4chp726sWaD4U0fTkFDYZ/X+ynopBGwRCK3i/hBMs
	 3Y1R5W2fJgAGoqOKwG/1WR3imUmUWZbaTV6UzTGF8JqJpmiAKISmtfJfEJ9wHXfUVS
	 D6Nj4nU7IuRpJkN16U34fOieKan2nvK0bWfcIyHEBj4rlm431zmbmvtLBHo60wzJNU
	 xHSSIGqgvWvLoVvRlnbAZryefGWhZy66UMRXNyABAe99meCauh2/DqEvlHvRGKXG+2
	 MzWoUJMo2qQVIoce2NaBuF9ekk2+NYz4/6J4zLPtqRftUG0H8Y7aDNJnqkGNErok4M
	 DnErARPseJXoQ==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC v3] mm/damon: add synchronous commit for commit_inputs
Date: Mon, 23 Mar 2026 07:22:06 -0700
Message-ID: <20260323142207.80553-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322231522.32700-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Liew,


I show you posted rfc v4 of this patch [1].  So I'm skipping this.

[1] https://lore.kernel.org/20260323021648.6590-1-aethernet65535@gmail.com


Thanks,
SJ

[...]
