Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C319580A
	for <damon@lists.linux.dev>; Mon, 23 Sep 2024 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086051; cv=none; b=J+vUXpBjHNRgbV397ZgkpVMzR3FTKxQ3iBQEvcAT1hdovdmoCPVXCpGvNcQvpP21x5qtQUTZfNNOdhWkkRqHSeck4TutYnAGx9+sMd5Za9vIlqD82JlFSF3ixQZ3uLdrOh/meKvWwd794SncT2wYJ7m8kFhBUXuEYNM+At4N5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086051; c=relaxed/simple;
	bh=TQpL3doUAOzqaH4/O3lCAacdc2AFb3+M/efOrt9mt74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0LSSddln55we+tqnru/Tzt3mPBpcUIWTpYuuNCKB8nBcvwxxSfmcz0nTDu3pluDYVul7MdOwFH5L1ndFtTnNHvx90MqKcp4eTQ1fOoawz9w0TsdMFe9E3JeAoJX0EFXSzbPRJxWKrkBjXSOj5C3VKzP5c70ojkFB+hHaZ9MbcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=Sej25HZv; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="Sej25HZv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1727086043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oCYcTAl+PnkECGw3Xrm07VTjSkzOitgt3KoVAnQzsKE=;
	b=Sej25HZvJ5ZCAj6DXEJVKc8iRhTq9vBj2P99vmv82/IeV8OHXq9Oegowka8vD7wCYOi7N2
	q011T3UJ8ulPlmLETWCRzIN7zOmhH+toIG24XoEQf57Y9EJiO1IDc18lf7qCy8fWQIWJIV
	+t+taNC/p3jmBjVbNTSx7a+ig6gXC8GqImzz9BY9RyiKikfVUOKyKSbfLdFUInBaYl9bKC
	G+iEKhUomQ3QO+neJluHwGiVkP/MQweBKN9GypNq18SgZyuXCE0Zh/J1R6EIBsav8AuvaA
	9u04oGh1qzBqwDPhtS1GwWR+X1p/LIn89wdadiSiDuMtWLuLUWqOA2ubD4ku/w==
From: Diederik de Haas <didi.debian@cknow.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] mm/damon: Update DAMON doc URL
Date: Mon, 23 Sep 2024 12:05:58 +0200
Message-ID: <20240923100615.14160-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The old URL doesn't really work anymore and as the documentation has
been integrated in the main kernel documentation site, change the URL to
point to that.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 mm/damon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index fecb8172410c..35b72f88983a 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -9,7 +9,7 @@ config DAMON
 	  access frequency of each memory region. The information can be useful
 	  for performance-centric DRAM level memory management.
 
-	  See https://damonitor.github.io/doc/html/latest-damon/index.html for
+	  See https://www.kernel.org/doc/html/latest/mm/damon/index.html for
 	  more information.
 
 config DAMON_KUNIT_TEST
-- 
2.45.2

