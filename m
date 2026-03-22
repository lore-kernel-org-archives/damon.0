Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC42F3C13
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774205217; cv=pass; b=XwP3gbN7pQv/M7OzBdVv2URr4cr42Nj3rC6gJGwvnE85LiL8U4H2q7DpeVAfJ7EBNfDfkvLYPpVAb9eFP6C9EeLhXSv5YzeiWvr0SDLWE+HMJiwZPllAo5G7LrrfvkLQuvWu8luziJqczvqwo/aK1vWRTWbR96n1Hjvo6pJUz4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774205217; c=relaxed/simple;
	bh=hdRO+VeXZ104nZ4ShRIHd5X2LWE0gjrPBNrcfaopg7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SD1gT/eDP09c3EhywN0sNWWL6/UxJyqMqwbFJujV1wyhR3kauk16T7Uy/VowUQIbprEK90rdV8tELcNElIFH10dWEvH8yvUnR0VrIx4CswiwHKNprZQulfydTEQ/gBO3drcXU6w6wxL0DjHzwkeMRWwXjc+/D2Hr191HmUUX0nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Fm9olenF; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Fm9olenF"
ARC-Seal: i=1; a=rsa-sha256; t=1774205204; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=G6qSSUmeIVPvaac9VT8iADN1XJY/eFQyZwhUO5zGkaVe9XzRVMxXjFwY0OE89tJutsUB2th32WiT5mc0zpqXf1Jm0dSmWYW39CqXLDA/Qs/8FCnMepEoYVRJmor+gnghGtreIVgNxpWEPNGv+TnDCKA2RpoDXrC2Z/mkmJRzX50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774205204; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YQm1d556B3o+NaQlArCokCh5J8Tddej2YfKHsXWYfh0=; 
	b=JwTiG/l88lM/FDXmHT8xDtTzxsBCUPCMOYX0Ibn1cWBDQL8foSjmEx48H3Nga/fbRRFc/MEaKOlE9vV5WC7ovjPzRtH1ZDsi27xi0s41UnzU9dBzTYaZqNoR4DdNOjw7H71ginb+1RtH88do25Lv8ib9PxKn6OZje2bm73jtiMM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774205204;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=YQm1d556B3o+NaQlArCokCh5J8Tddej2YfKHsXWYfh0=;
	b=Fm9olenFTvPJn4JqOUXMkYAuFW74wBtmXrBLDbQ6iunfj/83UacmwfDlxVc8RZgT
	aANrejF0QQe3921T8CinmK5DtAAPsT4tlQqUz0dR9z2HCzfh9f9x8urjx5PnBUpZhfJ
	jMPx/Am5+pR9AFKhItniIr171o9yE1XiULyxDB9E=
Received: by mx.zoho.eu with SMTPS id 1774205202996255.6842497561811;
	Sun, 22 Mar 2026 19:46:42 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/damon/core: performance optimizations for kdamond hot path
Date: Sun, 22 Mar 2026 18:46:39 +0000
Message-Id: <20260322184641.251966-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patch series provides two performance optimizations for the DAMON
core, focusing on reducing unnecessary iterations and eliminating
expensive hardware integer divisions in the hot paths.

The first patch inverts the nested loops in kdamond_apply_schemes().
Previously, it iterated over all regions and then all schemes for each
region. By iterating over schemes on the outside, we can evaluate
scheme-level invariants (like activation status and quotas) once per
scheme and bypass the O(Regions) walk entirely when a scheme is inactive
or has fulfilled its quota.

The second patch eliminates a hardware integer division in
damon_max_nr_accesses(), which is called for every region during every
sample interval. It replaces the division with a read from a cached
field.

Together, these changes significantly reduce the CPU overhead of DAMON,
especially when monitoring large numbers of regions or using many
DAMOS schemes.

Josh Law (2):
  mm/damon/core: optimize kdamond_apply_schemes() by inverting scheme
    and region loops
  mm/damon/core: eliminate hot-path integer division in
    damon_max_nr_accesses()

 include/linux/damon.h |  3 +-
 mm/damon/core.c       | 72 ++++++++++++++++++-------------------------
 2 files changed, 31 insertions(+), 44 deletions(-)

-- 
2.34.1
