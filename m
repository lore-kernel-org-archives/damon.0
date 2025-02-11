Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE7261567
	for <damon@lists.linux.dev>; Tue, 11 Feb 2025 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296733; cv=none; b=un2iK+3oC8FILMsuJNUYI0FUrqmLufsljm1CrgGziOPS6QpDehnhGW2OzhtKneQQAx3yz0qHQBU6KcHa0uXXixCwGshru3bjtVcketS+boYylTUO5SMIjBnX289upH29rv/VsfzhEWaS10fQ16wJmAwHu9EYE7oNL4ox1Azhy54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296733; c=relaxed/simple;
	bh=aBWoDYzCWBKmG8PWAl092CgeKoYOVvd18Y3WF3Tt820=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCka0lCUUmAhwRnVonlBxHZ6wdkQYIEKk5ijntYtHCxwKEDpc6akZCHQcEj0gXOptdtqjX8hKpsi19/ypmsOgBhaTEARFSSQ7/SGnSE2qdcqVM3zkKPGFYvtbNNh5+iN3hQKIXvfxtsNd/rTsruVRgJWYfwngCDOfXxkioKP6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etM6q3rO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etM6q3rO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCD0C4CEDD;
	Tue, 11 Feb 2025 17:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739296732;
	bh=aBWoDYzCWBKmG8PWAl092CgeKoYOVvd18Y3WF3Tt820=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etM6q3rO1PXW2Q9Ad42wisl1oibl4mRmksPcUKzDOOkORHxnxN8oPAFzOrE82yPy6
	 5NeqJlAz9l6waHWZn1s8EBOvyyiKUq0PEtMP/AbMnhLFnteLHIlcUS3juJvS7UJRAB
	 y9UcxJf2tjYrOiApaLmz5GWFPdOg/HN0gXI2ChFGUfV+xFVVyUN2568cykfRZoXgoZ
	 useVorw37Ilxi+b9DdshldzbY/gLQnS1z8m9TQgomk5u5xCeEqtLcg+ON33BXUBQpT
	 iOyJM3hyKWqE20q8drIGx5S7O2ouApFvG8VE3UjsyB3cBqVb0qYA2N5Yg5tCQrSP0/
	 ItTbnxxHRUDwA==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v5 1/4] mm/damon: introduce DAMOS filter type hugepage_size
Date: Tue, 11 Feb 2025 09:58:50 -0800
Message-Id: <20250211175850.10748-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211124437.278873-2-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Feb 2025 12:43:40 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> This is to gather statistics to check if memory regions of specific
> access tempratures are backed by pages of a size in a specific
> range.
> This filter can help to observe and prove the effectivenes of
> different schemes for shrinking/collapsing hugepages.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
