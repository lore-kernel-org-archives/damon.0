Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF2380FF2;
	Sat, 25 Jul 2026 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013361; cv=none; b=oGIHSnslrC6mkNNRMgFb1cfGlPWwon7Vt2ZplWmhviAM9YIJjUE1CKjf9nb5YBlr8U6OQfUAhKHRbyGe4jQDsMyeFkZOsEx882jepr5HhBf3oRPhhQgCK9ZRNNt0EmqyTnV5WLYAJtmmaf34whG0MbCPuFoC8MvGb5u52XAypoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013361; c=relaxed/simple;
	bh=llo5+gV9pnB1/RZRzV4H9W0eVGL+ZdsEibs8sEu0Apw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7lnYXtS9OlKjaG+qQcBvW/ghuRK1Iu6m+K0QmXwqhJ/R260821KkS6EwNQ9clKwhU5Lb1fSvp5+InJwt83N0maYHuGy4pI5CV1GCO24Ywkmbqfk2s81jMI3zIh7SCwgiQ7BDgSk7Q5Ag0dSThWLtjn2/61TVo8pD5IkBhByLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrw9fpOj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrw9fpOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2DD1F00A3F;
	Sat, 25 Jul 2026 21:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013360;
	bh=DL5R4ny6wLlfbUwSF8IPEKmxBCfPJcB+Bwsr8pb15YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nrw9fpOjsyc5AXWhE81QJBrNDwn5daxC2nF65w3wDf8NRQdPlkuA9YG02kY3Btn6j
	 hoAMufMpKL5uR6C9fraSoSoG3Mox9OcYEdtnEFQB74JqH2PHtBR7d2Tjf50l8p45d8
	 UspB28jK44t/VoZVWScHe/jenTgRdI/2rdCyL7o6zT0MlW6ft3124sfKfHkCJtapE1
	 9YNLwWMhgKbbxBChIJyXLYNi/usVcnteqo0xNGoJmHolF+ppydh3P2RifoAf5NlNVl
	 KLB0cPx/ycRiRNULQ0C0Wh257Rp1mAie+9AEHzEG4fDG4POuDTyr9uVai09VdGD8nN
	 1pM2DG2Ap4LZw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 15/17] Docs/mm/damon/design: document probe preps
Date: Sat, 25 Jul 2026 14:02:19 -0700
Message-ID: <20260725210225.129944-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added DAMN probe preps
feature.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 12a2c3f81a262..5ce777c6b3f30 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -311,6 +311,13 @@ Users can therefore know how much of a given DAMON region has a specific data
 attribute by reading the per-region per-probe probe hits counter after each
 aggregation interval.
 
+Users can optionally register probing preparation actions per probe.  If such
+actions are registered, DAMON applies the actions to each region's sampling
+memory before starting the next sampling interval.  Currently only one action,
+``set_pgidle`` is supported.  The action marks the page for the probing target
+memory as access-idle.  This can be useful to be used together with
+``pgidle_unset`` probe filter.
+
 This is a sampling based mechanism.  Hence, it is lightweight but the output
 may include some measurement errors.  The output should be used with good
 understanding of statistics.
-- 
2.47.3
