Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2242DA76A
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784605963; cv=none; b=hP436cbBKNXgx+BEfO1zGHLBm1ueay3RsnFbvcQ9xl5j/2fCnXSzsgR8mtZmP/9hcxDOy4Cfyw3P/uQOVSMBi9DrkrJkNdqtYPGuSvO0sUh/xZeAn+bI8bXTKeidA0rNOtiTsBrjhObgsLutxAWC1TmYO6jaAF8Y27Jibwz/6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784605963; c=relaxed/simple;
	bh=VWvBHRh4e4xaUNMm7jzFs4QZK9CG8uvo+JXem6vo5QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQfzFzTxP+BEvbrEFjMsbi2INBP4yCuuPV7OnFSucD6b80a0BZpLXNumbgeB2t+D1bsaRLi/c79NDRZCl9SV5K3eqxDDwPTFapRsZ4t+2ldYeOpkJIJbCAjdyMYXfjB6YTP9vSvU3V5wQ5v1FL0KF8vFcEueeQiTifnDLF+A5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orSzLAcb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orSzLAcb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB621F000E9;
	Tue, 21 Jul 2026 03:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784605962;
	bh=YRhh/wkXKBz8t4A7lrXcvxcWYhHRWJRlIpZzO2aE6vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=orSzLAcbZa40gPv4ubhUDYLOTFtlHe9R4zH9oi41G5zXCZTagWJBOFRr+cjCP7wPQ
	 oZPbe/iyjpy44jQ0xL3ifXbYNWoUmc+C8TtuSAzCWY6C59qIvrwPIsxl6C8hK5hoTl
	 W66HyNaWU9XBIkJf/wOmTDi1IRlEzhHF0ew1qPDknd7Smbo53sp2+jFpvD+dfcfkF6
	 w9Xltn93H/iYtjB1ac6LlO4mDwEmDg7fr+OtSIYeop0A2vA0hxSYIienOnOEHEGhUZ
	 m+l9IZYMluWbwvUxkjPfABcu8JkXctGAhZZZj4e2aSTwwYJCIytbH5+NB6DYssc9vz
	 RPRKgtPRT4QdA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	gutierrez.asier@huawei-partners.com,
	damon@lists.linux.dev
Subject: Re: [PATCH v3 3/3] Docs/mm/damon/design: Document hugepage_mem_bp target metric
Date: Mon, 20 Jul 2026 20:52:34 -0700
Message-ID: <20260721035235.147284-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720121723.BEBB21F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Jul 2026 12:17:23 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Underflow in total used memory calculation causes division by a huge number, breaking the intended safeguard and leading to aggressive DAMOS actions.
> - [Low] Returning INT_MAX from damos_hugepage_mem_bp() causes an integer overflow when computing the quota score on 32-bit architectures.
> - [Low] The newly added 'hugepage_mem_bp' sysfs metric is missing from the automated sysfs selftests.

All the issues are duplicates of previously reported ones.  No one is a
blocker.


Thanks,
SJ

[...]
