Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A961B81AD7;
	Fri, 11 Oct 2024 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666119; cv=none; b=YCnUB6J7F3SFvf3DF9t/PWXqAvu5hycx0LXtrHr5T1dx1BAzGgPXkbq142kq767Hd5z6NN94BdfwF9Ilu1HddltAoYxP00nHPfYEZO8JlzabUWjk+KbVoOGxrbaiHXrpVQK3c67N8LjmXoewLWFElfBMDNv4FpSyhP1EGtBIwSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666119; c=relaxed/simple;
	bh=gfp7YcV8h6o4AkIT/Iu3gx4SXfLeUBCwrRKHKh0qodU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bhWVcJvIxaKgQ21TBIRXHRfppAjy6FOA6Ao4F2OsQbbs6Qc527cjT7zBn1dvuxSnX4UuvhRmLaLyU1/Eesx9SY1/3J5bnNiV5dvcE9Cq92u/TstYSKZ+RxTG6VDcUEBiOtVmfcwSujlSHFXWBq5PlaSk25Ikskm3mkY134X6Isg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMWSQg4A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMWSQg4A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637F4C4CEC3;
	Fri, 11 Oct 2024 17:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728666119;
	bh=gfp7YcV8h6o4AkIT/Iu3gx4SXfLeUBCwrRKHKh0qodU=;
	h=From:To:Cc:Subject:Date:From;
	b=tMWSQg4AaHJ71TMhEXP7cwOF484TBudyd0WGvFSC5mkglBd9ROFL2GGWRoTJ/Uj1H
	 yVEsZuOktYky3/feBj6nnDeVym8c1YxfPXe2QuP1NjTRKhq3B1a5jKGVJIKRtDIoRD
	 rubFs7/M9sBH+9/TNsTyMsRnRLDfyJjzHlU4HZq1E6EbceXH9DZ30W/QoS0jkpYKEN
	 1ePJJsR6NbPdM2bi413GmjEEZdU9IaM0IFGGv7Wm/zMiTOVEwSJVwHpcIDG1cpMfhp
	 9KfJykDpvcwQXZC8xqPNevrNAZNchjdQJLRzU7bGhUtCKuX8EGdWlhQlOxZ+p2qzBG
	 k0idpVPaZp4Tw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Docs/damon/maintainer-profile: a couple of minor hotfixes
Date: Fri, 11 Oct 2024 10:01:52 -0700
Message-Id: <20241011170154.70651-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON maintainer-profile.rst file patches[1] that merged into the v6.12-rc1
have a couple of minor mistakes.  Fix those.

[1] https://lore.kernel.org/20240826015741.80707-1-sj@kernel.org

SeongJae Park (2):
  Docs/damon/maintainer-profile: add missing '_' suffixes for external
    web links
  Docs/damon/maintainer-profile: update deprecated awslabs GitHub URLs

 Documentation/mm/damon/maintainer-profile.rst | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)


base-commit: 7642dd55ac78c8050cb8142de62e32a4783020b9
-- 
2.39.5

