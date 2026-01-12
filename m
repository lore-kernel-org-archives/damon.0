Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E763612F2;
	Mon, 12 Jan 2026 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232203; cv=none; b=DBhP/w9S4P3z8Y9G4uirXMBh3EUttVCBKxIkn5uwXDk1CQ9454L2rf7yKbXfBek5XQvLuFWK9vrPP7MwkAL/kI5BjEIDnRstcrwYNJu3C0tQkX864L8Agt5isMlnjuPzJbCBX4nfx7pqiQIa2Iqc8gnBjiun7ttsiF1R8duQTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232203; c=relaxed/simple;
	bh=1IheKnbF9KpHc+KQVqpS9yoJRX/NZTD0YAWB4rwgNT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaWo7TvJNHpgI9SgNcmZnv27yUikTLyEO7Nt1Zf+gRqDWWLpQ4mb/qY3906VC2VYuCLYA8MXqdy9Spk7gNFnQJENeePZJ1PeeABzsRFyCPLd5GahikfrR0NzTKPmY+otTTapsryvdgacG9DO+OAPgiqa9aF8Dylg6RrW4VdY+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtAGRCCo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtAGRCCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF16DC16AAE;
	Mon, 12 Jan 2026 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768232203;
	bh=1IheKnbF9KpHc+KQVqpS9yoJRX/NZTD0YAWB4rwgNT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtAGRCCovJdx5faE/e1P43HebX5iIoYXJqMvilM5BAuONqitLKugP4IlpPxp+RnoI
	 Bfsx1G+cKPkG7BPaC19VOxzLYcvfFBFk1CJRXzxt8oaZREejHQapMXVaw4lm/wenFc
	 w8McvlFckcT2H/8i7Uk2+zz0oMIwNfMCuaAcNmhZJcWPN1brOS80PGalj9uZ+bNLXS
	 04MfUvqujte7dCPboRGrEw4bq9h75IECK50Dob22R4N0+yGd4bOolxe/7LvO2FUPjV
	 QBX8Hrh4NwNIMI2Rvlp4MG9JKaJ5LfyPU5ZimS/BV+QpdRBiKIdkex3ljqsaLxbcbH
	 nqbHyeczFuA5w==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	JaeJoon Jung <rgbi3307@gmail.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	wangkefeng.wang@huawei.com,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com
Subject: Re: [RFC PATCH v1] mm: improve call_controls_lock
Date: Mon, 12 Jan 2026 07:36:40 -0800
Message-ID: <20260112153641.98331-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <909dbaad-f0da-4372-a151-a393619da6ec@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 12 Jan 2026 13:32:59 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

[...] 
> I can submit a new updated patch with this small change. However,
> I believe, as discussed before, that the improvement in general will 
> be small and it may not be worth it.

I agree.  I don't think we need the updated patch for now.


Thanks,
SJ

[...]
