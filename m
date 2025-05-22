Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35037187876;
	Thu, 22 May 2025 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933858; cv=none; b=bNP2zH0SSrpPkZ0bjjrhtwYJjs6R+pLZpYZFTHArS5NcLf8eauB2VmfH+WntoLPij5JfRCcKiny4sX6nAEYj4sDlRBR92iKhWkgKnfI0F+AsNAKgOK/IBfSDTk0o/+b/OzFHrvJksabmIoIwERM4L0RnmdfngkL7dsjgJGdT98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933858; c=relaxed/simple;
	bh=GS8eJHSPlvgfz/XQ4sVczvmiCrgtG2LRFiQsLUHuHW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iiq7V90Msuw4c7ucEf/zkFJ/YbdlVTggr+FuZLjnCQb2A55MfYbDP8GRbJ8FNTRoghQSb83MvcuUKSlzE+SJuI+QYCOaQex62ar860dfyNk4FhQJ0I2249YZImDTUIkNxPhZcc6Sr5rKU0kkOEbC8zXuzCKsK7TUtcSBERDEfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5ZBSpkd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5ZBSpkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB82C4CEE4;
	Thu, 22 May 2025 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747933858;
	bh=GS8eJHSPlvgfz/XQ4sVczvmiCrgtG2LRFiQsLUHuHW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5ZBSpkddshVan9vzUHi5BelYJPKQb2U8WnfzsQHGDzGV05vm7ch80xZV/sMMPMim
	 cZFOEgVIQbVX3BktCeJ/Vwcs0vzsvhJgYXQz79yt3rgGB52EGx3YNJzApQH7tr3tQy
	 93FzkbnOePlogYUSr1rOtEJoVL8PCnZEr+PrUi5B6hkVd9rAWYACQEcbPf7YB4iV8j
	 Da72gVI2oP9LKC1z1jNksUzA0jdjDy3M1R/VEZ8ByvRVkv6pgBvVxAvkpvpvVrO3He
	 /P7TzpYC7e8PMa3SCcf7mEjymnDjDLUDi7OLpm2n0YsZidaec0a5qnki014zeeeCsB
	 5O8iNGcpLJdoQ==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/damon/Kconfig: set DAMON_{VADDR,PADDR,SYSFS} default to DAMON
Date: Thu, 22 May 2025 10:10:55 -0700
Message-Id: <20250522171055.56993-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <35593bd8-85db-4490-9f18-9d9674d5c6e1@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 22 May 2025 14:54:33 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> This is the patch I was waiting for.

I'm more than glad to hear this :)  Also appreciate/apology for your wait.

[...]
> I'm not sure if I'm elighble to ack your patch, but

I pretty sure you're eligible.

> I would like to add
> 
> 	Acked-by: Honggyu Kim <honggyu.kim@sk.com>

Thank you, this means a lot to me!


Thanks,
SJ

[...]
