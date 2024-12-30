Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1DE183CA9
	for <damon@lists.linux.dev>; Mon, 30 Dec 2024 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583953; cv=none; b=SsYNfAq4mKQjXz83R7587mky6ThUDKw0gDpJnR2BJnMQJ8gf0CN4R37HUu9HBSL4f2YmAVID/6uQ5Wha6xCXfcWL5i9Ly4dta0rJAkCrqsce+meS3jAAZN6mT8zY86sRkLAldctBYxZm9WX/sy7yGVHkebt4WRrCJQZg6lDtVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583953; c=relaxed/simple;
	bh=TlTsZB4dqOfyM/JAiGXUcKKaeXGjD/fPaKZo2aWnyVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bP+JpfK2BTV6NuAqwZ1czvk6G/uOQ2Y8Nd4rmSkyvLi4TpCIx/rjkbRnS9IMflwCh62ncu3oOIWvX3S330SIGxYPAkjgz6LsQdGGqCJFaWMlE2WJHZ0toZJgWZOJuc59DxKbslv1nx1TMcIDKo7Ds017fuCBEgu8wS2LmUjzwi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBhKdope; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBhKdope"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68FEC4CED0;
	Mon, 30 Dec 2024 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735583953;
	bh=TlTsZB4dqOfyM/JAiGXUcKKaeXGjD/fPaKZo2aWnyVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBhKdope/QzVMW+2kVPwZzfYAuu85UMhf/OOk18np9zD+BP4xD9n6X7CQ0U9HFpA1
	 H+9/h+Uo134fOIcfrmGSzEjCZfeK6C/2JxluX4ToJLP1z3VW7jAfwsd0hi752A90GV
	 gX5lC+AAGMzjbzA744cm0C8kRHHB/JyLfGv2oR5WN0lgvAjvRE54AsLwWwLrXsm+3M
	 hCNrJYItIH1HMdggLTMWawR3l5eniEyW2Bev9XzxKXY19Hw3UhjH9pQoQUuY56vNeb
	 /nRMrr8c6tlexQwg5Ew5N6uajrx0EahL9TbgDhOCakAMBMA3hWVSq2WEIWRuiZheIE
	 MYdPOLcVtKX5A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: trace: print address range in hex
Date: Mon, 30 Dec 2024 10:39:09 -0800
Message-Id: <20241230183909.14559-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241230182813.14349-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 30 Dec 2024 10:28:13 -0800 SeongJae Park <sj@kernel.org> wrote:

> Hello Akinobu,
> 
> On Mon, 30 Dec 2024 22:42:20 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 
> > Currently, the address ranges are displayed in decimal format in
> > tracepoints for DAMON, but hexadecimal format is easier to compare with
> > address ranges in /proc/<pid>/numa_maps.
> 
> I agree that it could be easier for the use case.  But, I think writing and
> using a script converting formats for DAMON tracepoint output or numa_maps
> could also be a way to resolve the issue.

For example, we can extend 'damo' to optionally do the conversion.  Depending
on your use case (if you also use 'damo' for your use case), it might be a way
to move forward?


Thanks,
SJ

[...]
