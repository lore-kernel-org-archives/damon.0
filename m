Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E99926157B
	for <damon@lists.linux.dev>; Tue, 11 Feb 2025 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296863; cv=none; b=DWZcSogp15nycFFLtWKHKVNc5jL1QWPJ6vxCUWnNWhz6CrvqmFtFUqqpzBzBN8Wy/DKwUcifbawxPPQZPS6IAqwSlwA/4LGDx+Ht4dynJrN82a1NTvwvLLEve6VyfFnBggtq2wncYCkIWkGbjrg0G1UUMZbWPqH6Y9wXprj7myQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296863; c=relaxed/simple;
	bh=I8OsHDB06gpwqOmgP7+mp0wu9Rolwy/e5uvXBkew0J8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZ5cN/kC0g7Ngqgq1APjj3o7swetHKCTeAhk/JuMUAKkpV/GGwwZV+boYmUaikGr80nVb3VfZZch7PPkYB3nvgiVxdy/BMcdIpTOfY9Dka6lmg4MhY/840B1UTX2YfKGPIUKsgX+ljrZlC80JwsgBBQirU+WvLmgCR5+GaJIKBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoo/OPLV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoo/OPLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F70C4CEE4;
	Tue, 11 Feb 2025 18:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739296862;
	bh=I8OsHDB06gpwqOmgP7+mp0wu9Rolwy/e5uvXBkew0J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hoo/OPLVgytBCudcRMYiiRG/mouQGQwCBU1C1DpaVI+LKl1D7vhQTx+ZxHIAdD/+8
	 1o+TPigtJGN5yj3qEmQrc6r2g873H13WS+oR0i6fN4CXFaMrU7hUPttKpsBtChsWPv
	 ZF+ENk2+eP2fppcV1n2Y8JH4XEUTMhzKxphvZgQRN8cbOzZYgQ9LRatfn8hpdcd/Ce
	 VT+GJVesqWLfXLpvl99pu+OX476VCuSudV8QXbJT6Ij2CRfMdrV6wjrFf58kfBTRxv
	 tWkUZ9WH9EnSlPXNij0gTd3Ql3TMQ3Jw8eIIZwtcDppe2v/bt7JbuVKwlmil4x8vUO
	 mmu20CxUuDNhg==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v5 4/4] Docs/admin-guide/mm/damon/usage: Document hugepage_size filter type
Date: Tue, 11 Feb 2025 10:00:59 -0800
Message-Id: <20250211180100.10907-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211124437.278873-5-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Feb 2025 12:43:43 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> This includes both the 'hugepage_size' filter type and the min/max
> files used to decide range of sizes to filter on.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
