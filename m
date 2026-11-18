Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012570;
	b=tIxxJxqx8+H1y+puUQFYZ4qXQQm5syxEre4VLLz/72WML33lqdnxU7OoIH9UMjIZas8V
	 gfkwzYmTdU/xE8l5xGCiwyQVcNAGLoOTpbU/KZaTj4dU+l5yxi5qjSKYaDyaTzVTNIB/9
	 7U8rZgZYyXNOS14CR/KiQfeQ9wNMLqK4EkZw1oMMZrWNUJE9l7YOVpuEKyLts+xolHvXf
	 dHIy6lSI0jBZXojZjUILGqPCf7KDLHA+6UvoOPFtzNgZldqMx3pV+j11NILaBMcz4LRBI
	 tVTTxhzK4WO5LymCIw2v1fJL4mEBEuYM8k9zyEIETr24MkXYowO7ywUKadgeGXA3lBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012570;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CTJ6/5WzE5JCaK+BecloYss1do/yUv+G+4PNfkm1tUE=;
	b=0ajLTIMdzvhlyFm5uLE7zSesyAux3t2D7ozyL00bcuUVYF/fYM2OCW3B8KIUY6KiAONI
	 2sK72WJuvdBlpt+oo5rsqA1hIzwnhke/KttQDkpyuEbqw7q1e5zxb1tKjZD7LjVcCaN/b
	 SSOi9knUaxNi+Nx+GkxLTUbgKFyd548ZCwA1XYOAYCu79yCrGjW5e5m6mYJyGWeKUyhz3
	 povPxjlUCrVSpZvaKnlwu31PlyPPR71Fv/Q4jxotjuDhWJ63A0/O2J1J5sG3j0xx53uub
	 TKcM+AQ1wIib4FgiTIbpLZCCEa1dQc3E8IIqsnCBLyjbXoCQo7jxaClPckw+jnHfROg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KCLEdvBA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AF8606A338;
	Wed, 18 Nov 2026 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KCLEdvBA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A381F000C4;
	Wed, 18 Nov 2026 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012570;
	bh=CTJ6/5WzE5JCaK+BecloYss1do/yUv+G+4PNfkm1tUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KCLEdvBA6rxiK2fBZFHlt+emAzYHcLNBNuWT6W1cVvtj/QkHKCbayq8rXMNQqHmiE
	 QG08YNjQB6j8h/O869KvqwnvmKPmcVIXcbvlWAnZ7uimQEHirzPAOFazn8bM62DNru
	 KJJA/Sl7sobjrLTiNT7FadHW9qtxt27IghPR6NWmtNyV+K2Fj9HKN1ArgshlLztngY
	 lhu74b50bLSxx3/jlx4TzmOwF3saTqzenvUlyuOC5VKaEKDgj1bDw4UATfoqSEgeVB
	 jEMz/JSZcpxX9WDruvIkyK5QE2HDrwgJHy8yP+P4bWFJJcUnB6Dpa50CCNsGqcQFs5
	 y5tnzU9V8fn8Q==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] mm/damon/paddr: skip non-LRU folios as a whole in pageout
Date: Wed, 18 Nov 2026 06:36:02 -0800
Message-ID: <20261118143602.93103-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118-fix-damon-hugetlb-pageout-20261117-v2-1-547a65a3206e@gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 18 Nov 2026 03:24:28 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> damon_pa_pageout() uses damon_get_folio(), which rejects folios that are
> not on the LRU.  For a large non-LRU folio such as a hugetlb folio, the
> loop then looks up the same folio once per base page even though
> pageout cannot reclaim it.
> 
> Use damon_get_monitor_folio() and skip any returned non-LRU folio as a
> whole by advancing to its end.  Do this before the filters, the
> accounting and the last_applied check, so that adjacent regions within
> the same non-LRU folio are not walked by base page either.
> 
> In an x86-64 KVM pageout microbenchmark, traversal time dropped by
> about 99.7% for regions covering whole 2 MiB hugetlb folios. For
> 4 KiB regions within hugetlb folios, traversal took about 1 ns more
> per region.
> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> ---
> Tested in x86-64 KVM guests.  DAMON KUnit tests all passed.  Ordinary-page
> and THP controls passed the 3% non-inferiority bound in the microbenchmark.
> 
> Changes in v2:
> - Drop the redundant hugetlb check and update the subject and description
>   as suggested by SJ.

Nit.  Please add a link to the previious version from the next time.

For other readers, the previous version is available at
https://lore.kernel.org/20261117-fix-damon-hugetlb-pageout-20261117-v1-1-054ef8760a92@gmail.com


Thanks,
SJ

[...]
