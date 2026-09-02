Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D279248F822;
	Wed,  2 Sep 2026 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359118; cv=none; b=cgnn3s43Wyx4Gno/hLEvS//+a88SHy8HCYp1BNr1rru8vpsac6p0UZzj9J6telh5tNKPzBFFcgK2l+SIf+0iMqqvqhbLddzEVXqmYXfGNCv6A3Ok8mq3Kc2n8QfvyWa+i8XyD+Nwred+LV31DGBK+ATxGa61p+0EJY3Jh2cle5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359118; c=relaxed/simple;
	bh=ABvitbBs+ZI771uUOo0bg7SscWD7LgxjVsiglzI0+RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrm0d2OlY1LUP5pGzi5qW+ITgdKLEPurQy3u6UnYnlzVRb7dOzeL1xEOMzqyvBtGfXzYo8WCH6Fx9EoYSYw2DqgUQ0W0TOxlXzStR2ENI+eD81Ht9ciQT0lQj902GPpMIOjxSdJ7juNRDkwoYhggVcYS0GOTfg6mktBnmroZmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd3okxwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd3okxwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0131F00A3E;
	Wed,  2 Sep 2026 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788359117;
	bh=dwH6CzjmhB+SmHrUUzJ8KL/hFq+AZimRbmxhGf36Cd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dd3okxwvRWja7d9dxhaloYRzmW51U2RWUrlPNhitArb9FLFn/8CiJO80qz3SrZfac
	 2130tW2M+GIuNq8HyjRRg5idQqW9AwBD5cA4SXWyuvu8t4ZvuAi54oQ0wwYCZv1vYx
	 Qoio+2r/j41c6HH/CsD7IkCm2D2Y9BWUev3KpjwBlj74Io1nMsFLbBlQci5h5fOKyP
	 rBjGVMu4Y9VfTAC+Pi30uYrdX5zx79HHCokbzSeV0/cH/iqEO+Gl1y/6CzlIjZ2iUy
	 jWcIbB23ujFq6l0VbD8oqAv5S//E/oQxktCfQcCSLcxQQRGJKmMZ8c2D4eXimQida1
	 EbLsFTgaqo2lA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/6] mm/damon: add kunit and selftests for probes and probe weights
Date: Wed,  2 Sep 2026 07:25:09 -0700
Message-ID: <20260902142510.87878-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902140313.85983-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Sep 2026 07:03:06 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON recently introduced probes and probe weights.  Add kunit and
> selftests for ensuring the parameters for features can be set using the
> core API and the sysfs ABI, respectively.

Sashiko found no blocker for this series.  Sashiko sent findings to damon@
mailing list [1], and I replied to all the comments that have any potential
issue finding.  Please read those for details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
