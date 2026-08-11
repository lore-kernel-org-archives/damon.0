Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B7443CEF5
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456373; cv=none; b=DYz5taYb7iKL23uZ7jIGq+bqjl0GPpNofYBM7Tw6de0rV9HWPHFsWXga1+BSVJilRa1d8gw2+GFPCCGx8Eam/4aNnbR+92WFr5TjLZKp4nnwwakyEq+SSsS/OvTbZKQv9FIMR7oa/NPEVHS13yuWNfc1riLjrn7z0Epc5r8hF5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456373; c=relaxed/simple;
	bh=uUxB+0m06S1tp0VSavmhmA2ixEGZOzpvrYNKM6A8ThM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxYHLhSqtFssUJ4iPnf8WyJH6QC3C8oBnItKLnkZcVSKtJ3sPiSn5xIIxAUQx7j7Vtg9RNfp7nis9LJJdHDVRGGmYQdGFQ8DaySeBnvZA2jCUEUxew5Z2o85FBuEyVfIOZEASMetK2QIH/SPBWbkI5kOtpH3KeTb5bayH98qU88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI8lKPFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI8lKPFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423D81F000E9;
	Tue, 11 Aug 2026 13:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786456367;
	bh=9Jv8mZDPr/MJb+TNlWFJFke/1QnWZMAtyRHDCHFmtSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iI8lKPFWx1KDsgmjcDLPSd1CLv9LAsxlBkP5dLQYcxswuEdXl+cLqYZXwz5KrtiIH
	 8cuIyydv9xDAEC1DUpd2zcintaqUw5QXdzPorw+l9yHayc/Sd6wQm4qJuhMwMvgkHP
	 l8BffRU+gNP9m+yQ659XBztqsvlZ1rSxYByZtwfAiLm17ZAqURNsM1JGqMjzrICRnw
	 V3buT0DVgc1eLXdrwePCBxklB1r5rHiY9kMQMHrV/wi97KJlhI6zDYpR3OqOwS90ii
	 HJNihx2vNv7+nxswspyiFR4SlC1XuofIrfyF3za0AStabc8qimVNVBmLsuze802xxz
	 JL2NWu48OZSug==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/3] docs/mm/damon/design: fix typo of max_nr_snapshots
Date: Tue, 11 Aug 2026 06:52:39 -0700
Message-ID: <20260811135240.4756-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811101841.804596-4-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Aug 2026 18:18:41 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Fixes a typo (nr_snapshots -> max_nr_snapshots) and corrects a grammar
> error.

Looks good to me, thank you for fixing these.

> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
