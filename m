Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34146492E3B;
	Wed,  9 Sep 2026 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914732; cv=none; b=f3WTBh3+9VEEXSxjLD4hnnNLgp9NcLMwSs4HTyuy7K+kCho/qBKM75MRzpHbT+zOELFTVj34urKqZZvKxzp+MleRCxlM3z+HUYP2TuQYZiEYhI8bPMn7x9eCrf4tjqmFes/4InpgGsFO76iPLu9zVdcnIcVmhgicPJoi2LcGsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914732; c=relaxed/simple;
	bh=TR7MTN1fGXA4hfoTIJ46T+NHldD9mwQQvo8T9xEWdXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZbfYj5G4Y8GiELfD4sxR+bF6jW0lRg9nswyDIqjuMZ7qr0NKLlK6pJ6qqEk+Zv8/p0Ja9KUnXp9VHN9tyu2R5YfAACuBTPmEh326bJEe40Lp/f4ztzcQbBeMt9n0Nw7Ryk8R90La2X91O12XwEaoBqriAym5YWlU3CTVchoAoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRMTXI5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRMTXI5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540891F00A3A;
	Wed,  9 Sep 2026 00:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914730;
	bh=ZNopAaAzl4l7FgpL2NX3Esneyi/PfV8GDqKzg7A+eWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRMTXI5LTdLH8UBQUVL75Ne4wsGyyqbLlOWfIZh8O5U92WQbxbNUZ0tyc9cMVwhj8
	 4C9Yt1aAExJ2jT+xMlwTtu24XMlk07ApGbQ3LXvjfjeppJuT+9iBJvrx4snpx3QR1k
	 20hZHkLkCl20E9nF/dFDNVyuVimE+CGV8bhjVFsbnxmJJ53XrlT9tFfuf5Mp/5Yy9o
	 w1klF/NP7eKnJOFW4VLKEgnxmWJZAweD7BKR8oX+Z8GasMv8Sr9Ci6AkK/lErrRbuO
	 kfftRhUZGaHSzN8mSs7LRZOTAv0Oz2tflAz6ylMd8ky9ERtu+pH9BnYhbgY6Pril96
	 OEigpzFjTAHTg==
From: SJ Park <sj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH] selftests/damon: ignore test-generated damon_dump_output
Date: Tue,  8 Sep 2026 17:45:22 -0700
Message-ID: <20260909004523.112863-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908162716.85648-1-zenghui.yu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  9 Sep 2026 00:27:16 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
> 
> sysfs.py and sysfs_no_op_commit_break.py dump the DAMON status collected
> via drgn_dump_damon_status.py into a damon_dump_output file in the working
> directory.  Ignore it so that running the tests in-tree does not pollute
> git status.

Nice catch!  Thank you for finding and fixing this!

> 
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
