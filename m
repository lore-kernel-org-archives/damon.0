Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D3B231830;
	Sun,  5 Jul 2026 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267314; cv=none; b=Yq19I3AuExZR18opb659gPdUnSPW3FKtmPRn3ftMhCtnybUJZ+kkekzmxtkKzjp0vXOHnilKWa8ctlAxRoYCxiHS6ElOFDxboKvw6JIrS8rTEX6GWhgJRnBuX08gvbHKxZWatzt1zjqPALSGjPsrfGjbGM6V5MquROQT0B7c1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267314; c=relaxed/simple;
	bh=GcM9WomvUelKQMvW2BzflF22wI+CxMC31EP1q4nla1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6YmzmAszEwjQPar0wn17R+4h0xPP4FaYwnTH2JTUUQ+KkKF2tMNMDd15oBTHq0tSFSLwsBEZR5SRhZjkxlNFeNrfm0G+ZXB4DAiva20PeUwJ1+dhEsh+mD0HB+GfkUGzbfFZvh2U2yqn5H+jDFFTnBNfvE2zovXgnAoOpLQJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJnISSxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJnISSxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD5C1F00A3E;
	Sun,  5 Jul 2026 16:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267313;
	bh=iM2Eb2ExS7GI1ym8vhWA/m10zp74Amrd4zSKSC4zHiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IJnISSxkkJUzL4ggSYDFJhQIFv0Z32F4ZOl0DDmnFxH4QsbgjxHoqbL2ds3NMBJaz
	 0Vr0Z5z40ckxtJCUW7Smftjol20RmwFJKSxqBOkhEQinU9yabVVVEU8bJlCT1WBtgz
	 hjQzUfvuyZKA2a0OeDMlbiv6Bql6E+DfPgHuTb4JhyDS+Jamk71ZiSfjJ1AWz0r585
	 1OyKPBrp+UwYqsQfWijfN3bq+w55tHPsd71mh/+e4nPbs6iBycY0Mzrm0j5vhSuVJX
	 7kdfg2OM/yt4ewIYs4EpNtOUaB7/cFkk3AkPBl+8WciDRScYkjTXdoAtW5KagLSd8M
	 0OHTULEOutL1A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 04/11] mm/damon/sysfs: ignore damon_stop() return value
Date: Sun,  5 Jul 2026 09:01:31 -0700
Message-ID: <20260705160142.97308-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705160142.97308-1-sj@kernel.org>
References: <20260705160142.97308-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_stop() return value is guaranteed to be 0.  Ignore it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b65651498e0d1..6d7e36c9e509d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2262,12 +2262,13 @@ static int damon_sysfs_turn_damon_off(struct damon_sysfs_kdamond *kdamond)
 {
 	if (!kdamond->damon_ctx)
 		return -EINVAL;
-	return damon_stop(&kdamond->damon_ctx, 1);
+	damon_stop(&kdamond->damon_ctx, 1);
 	/*
 	 * To allow users show final monitoring results of already turned-off
 	 * DAMON, we free kdamond->damon_ctx in next
 	 * damon_sysfs_turn_damon_on(), or kdamonds_nr_store()
 	 */
+	return 0;
 }
 
 static int damon_sysfs_damon_call(int (*fn)(void *data),
-- 
2.47.3
