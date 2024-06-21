Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C15D477;
	Fri, 21 Jun 2024 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987792; cv=none; b=peRSI9DDu8f88n7DKencFIm3RCbUz7uy2gbQjceAZX+RlxC898zqHGudvNvn8RZPPcg3mDG8kLnHrY2QN6vY22CRCHtrzLdcXECItEj1UgwGfaI+lzQXKRhj5+eT17v8xbLAEeWBpOZ6Yg08iQNFoDjf76yPnukW4y9ec8rscFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987792; c=relaxed/simple;
	bh=EBKu7klaSZ+BqPmbszJnOK6EYNlz29Xg71pk0RW/pfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PekU51l69cDkJnlbwY1dpTAR1EWlUQRU2I0/uXwmN+lqfaEnq/KVRwdukxax2zInPqO109SlQVGMS0kCAKC2/QNINJJ+9vLqbOh+FPUfEmaL7uyflSoFYo19oaGHWpIk8OIgz8Gz2WQ2EOwC994ShKT+xHLvF5OWE/irWue4mJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2m+89It; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2m+89It"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDA0C2BBFC;
	Fri, 21 Jun 2024 16:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718987792;
	bh=EBKu7klaSZ+BqPmbszJnOK6EYNlz29Xg71pk0RW/pfU=;
	h=From:To:Cc:Subject:Date:From;
	b=p2m+89ItpLYXoMt3poZ7FTE+Q3J0qwO6A7jnjk5KYY4smdIEJE9F/rZOuotcZMVZM
	 hx4btCMgX7/EKtkWLv83LAHZuwC0DugL/6DNJOMdLED9qZFdcY6gf3dk+YRhFCaaWz
	 tx6HGssPoVeFQ5YysEl809KOwpnQ8laOfwlFnf0suUeATbqgZEpevhl1vl51bOV16d
	 vTaxhH+EN4eYn5s3dcgpc6HoZF4mvStb+KQ8lZqP2H2Aut7A52teF7jfUiwCieZt4c
	 tk204721Pf72rRIjm/4qeKECN4QdLiWCAnStg5vGLUNfo0Kuzo4+DwW7AFoyFGqrEz
	 OWb0QP48D49IQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Docs/mm/damon/maintaier-profile: document a mailing tool and community meetup series
Date: Fri, 21 Jun 2024 09:36:24 -0700
Message-Id: <20240621163626.74815-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a mailing tool that developed and maintained by DAMON
maintainer aiming to support DAMON community.  Also there are DAMON
community meetup series.  Both are known to have rooms of improvements
in terms of their visibility.  Document those on the maintainer's
profile document.

Changes from v1
(https://lore.kernel.org/20240620220337.76942-1-sj@kernel.org)
- Fix typos and grammartical errors (Randy Dunlap)

SeongJae Park (2):
  Docs/mm/damon/maintainer-profile: introduce HacKerMaiL
  Docs/mm/damon/maintainer-profile: document DAMON community meetups

 Documentation/mm/damon/maintainer-profile.rst | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)


base-commit: 4d89671e8d960b6d2fb11474fc1d635b78dcd6ee
-- 
2.39.2

