Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296CA3ED5AF
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935872; cv=pass; b=GPa3+WWVgruMoJxRRlZejNsmSeVgbpMavajiLs8/HAqAT8zFRL5gK2SE0O+Uj+essBV0RGdVbTQU3+yV270BFhfOlVPdKxf73xvMKL0RI0c3ia83KXfkuMfHY1ozws/MaayexLcAwj8vWEI8vjp+jsfGk1HYbjU3SRU6Y7cfu0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935872; c=relaxed/simple;
	bh=Zu6hgfpf9j6l2ALd3UnwnQ3PEI7s5UmGPKtSC/DswLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c+3hrv2NrmcE0EGKmli+raMw9Wx0cLSBc5m5WAxcbsOj0VeEpv1KYAa8LdHviQYzFiCVs8SzVLKV7nQpeZT6jBW6QGLOxDiRDTz+By0qVVWACXK8Q24UVxaNgncPbHXetFd3DNB/bspuNrS1fsnLl7zrJXG45xSFzQg4EcqJpLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Br9+Q7sX; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Br9+Q7sX"
ARC-Seal: i=1; a=rsa-sha256; t=1773935866; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=SPq2y71aDBZ5J/5FLM1uM+5uQdrLEHyPaM1jBJha8oL0BwSgwDlGzIcmmLeqbcPnfJZM/LSfsmc3g7vyviFpaMDHJ3NrXiBtqquP4MN24Y7q9ZR69aVLTJASBrSIsmaoO7Y+73xhXUxiKvPnEvEoFzf4kUNggWhQ2eqyQuzwfHI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773935866; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JI++XvrAXyvmflCj+6eweqyivjRiS4U41ATQdQdKzgI=; 
	b=Gk78sraDQakrwnl5LOsxeGy92KI/l3/eIHjUFyDeKeF8kykGow2H3hNSkGZvD9aHe7aZ6wBEDBXjFcwXc3J4WoknCr3QfLZ44Yf1AMupd6BlO080y3M5OPiFkQqE1TdwEbWXXyGvyzwADMQ4vPTplcf7Efmwas2LaBf2wPRBJK8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773935866;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=JI++XvrAXyvmflCj+6eweqyivjRiS4U41ATQdQdKzgI=;
	b=Br9+Q7sXl646f/z/NKxlgLNHZ9m6jMcQPRBQ+sWSU9bjYuCO15iA0h7ganMuf+HM
	G3yA7uYmC/6PFk9C84+VKrNX72rQeacadUA9svCeqj9/Uuf12CqZA2VwUGktpi4LaSW
	JIlUBYD0MtLBbp54Gisjg6twKLZBT/SOr3xUOcKQ=
Received: by mx.zoho.eu with SMTPS id 1773935864062723.0335759457625;
	Thu, 19 Mar 2026 16:57:44 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 0/4] mm/damon/sysfs: fix resource leak and NULL pointer dereferences
Date: Thu, 19 Mar 2026 15:57:38 +0000
Message-Id: <20260319155742.186627-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This series fixes a memory leak and three NULL pointer dereferences in
the DAMON sysfs interface, all in mm/damon/sysfs.c.

Patch 1 fixes a damon_ctx leak in damon_sysfs_commit_input() when
damon_sysfs_new_test_ctx() fails after param_ctx was already built.

Patches 2-4 fix missing contexts->nr checks before dereferencing
contexts_arr[0]. A user can trigger these by setting nr_contexts to 0
via sysfs and then issuing commands that assume a context exists:

  - Patch 2: CLEAR_SCHEMES_TRIED_REGIONS handler in damon_sysfs_handle_cmd()
  - Patch 3: damon_sysfs_update_schemes_tried_regions(), reached via
    UPDATE_SCHEMES_TRIED_BYTES and UPDATE_SCHEMES_TRIED_REGIONS
  - Patch 4: damon_sysfs_repeat_call_fn(), reachable when nr_contexts is
    set to 0 while DAMON is running

Josh Law (4):
  mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx()
    failure
  mm/damon/sysfs: check contexts->nr before clear_schemes_tried_regions
  mm/damon/sysfs: check contexts->nr in update_schemes_tried_regions
  mm/damon/sysfs: check contexts->nr in repeat_call_fn

 mm/damon/sysfs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.34.1

