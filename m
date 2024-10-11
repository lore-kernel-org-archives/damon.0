Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9E1BBBC6;
	Fri, 11 Oct 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666122; cv=none; b=nmpw643mjebfVqRMd7cGYJKqreAFxQa0ts5crKH7lc3m7xD6ZZsNFBQP1j6KOtRGNa4k2ohcsc84pPe7hQ8qu67UT93WBOGrB11HrcZVM+kDrXFUJUXBJ37MAPI2nWcBTG82X8uxZPlp+k6kDn2cbsDmyZcVlr5LiOHAUZoWUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666122; c=relaxed/simple;
	bh=ZPCeKzFnODdZ4oh5o5TrQQIAwiaQ5KJ5HlvR4ndp04I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KYdaE1HhHZgRy5NmUJUA6OGpyv012tWdMLoOf65l5j0ny3ERIOySLHStzIMl03MDr5530nsPEzM0aBTJ8lRPAPgcpHp3qBdcv0tznjUEBJq6y6K6hgr9l2olFu5sUxeDYFOfiKedhu53GGF5SwxTfh62F2c1TCu1LhTB8kyudCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDxWsVxm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDxWsVxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90494C4CEC3;
	Fri, 11 Oct 2024 17:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728666121;
	bh=ZPCeKzFnODdZ4oh5o5TrQQIAwiaQ5KJ5HlvR4ndp04I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDxWsVxmHBINRT1gKExtbiZ0CVi+4j8FQn5BRPpFTvTKLAilns832Y8DgXUtBSMlp
	 9+r66otaUeXGaTAVh15N6gOBEciGc3BOe792MWWFTk8GF/tltoZBdj92DIXhR13sR4
	 ckExWcqeWqRhAiZCBhlJJOAVgRr9C9JkmgK3C6INDiqXjt6y16dy3Awhj1IV95hrzn
	 qqk1VovqXEfSodrOx+N6ilbOsJXBIv/AV1yF6pQjhOZyHo5kxdfytFboTA6cwIARGR
	 0pAxSwL+dY3y9H8sz03ATBTMcg7pdip+Knb4xG0UqbQNEUIjVI8VBXkOQSme2osADS
	 CkKjZjbY19hOw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Docs/damon/maintainer-profile: update deprecated awslabs GitHub URLs
Date: Fri, 11 Oct 2024 10:01:54 -0700
Message-Id: <20241011170154.70651-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241011170154.70651-1-sj@kernel.org>
References: <20241011170154.70651-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON GitHub repos have moved from awslabs GitHub org to damonitor
org[1].  Following the change, URLs on documents are also updated[2].
However, commit 2e9b3d6e2e59 ("Docs/damon/maintainer-profile: add links
in place"), which was added just after the update, was using the
deprecated GitHub URLs.  Update those to use damonitor GitHub URLs
instead.

[1] https://lore.kernel.org/20240813232158.83903-1-sj@kernel.org
[2] https://lore.kernel.org/20240826015741.80707-2-sj@kernel.org

Fixes: 2e9b3d6e2e59 ("Docs/damon/maintainer-profile: add links in place")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index 7b966480c79e..ce3e98458339 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -37,17 +37,17 @@ When making DAMON changes, you should do below.
 - Build changes related outputs including kernel and documents.
 - Ensure the builds introduce no new errors or warnings.
 - Run and ensure no new failures for DAMON `selftests
-  <https://github.com/awslabs/damon-tests/blob/master/corr/run.sh#L49>`_ and
+  <https://github.com/damonitor/damon-tests/blob/master/corr/run.sh#L49>`_ and
   `kunittests
-  <https://github.com/awslabs/damon-tests/blob/master/corr/tests/kunit.sh>`_.
+  <https://github.com/damonitor/damon-tests/blob/master/corr/tests/kunit.sh>`_.
 
 Further doing below and putting the results will be helpful.
 
 - Run `damon-tests/corr
-  <https://github.com/awslabs/damon-tests/tree/master/corr>`_ for normal
+  <https://github.com/damonitor/damon-tests/tree/master/corr>`_ for normal
   changes.
 - Run `damon-tests/perf
-  <https://github.com/awslabs/damon-tests/tree/master/perf>`_ for performance
+  <https://github.com/damonitor/damon-tests/tree/master/perf>`_ for performance
   changes.
 
 Key cycle dates
-- 
2.39.5

