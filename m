Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F2230DD07;
	Fri, 30 Jan 2026 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787843; cv=none; b=lqkGmXioDVxV4B3kywDUBmyAn9b6srZx30ScrSrVthpzkO5Of0PJAZOBurK4HkjxrkBlrHCW9DfIPMPhm8q2dML0bmmx6jDqTUyRGja2ccrIf2Q9ItsfQkF3jUau7XCLBo+aYxg2WQqi2EjI9E/w89CSJPeXShaHONx3VzqsnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787843; c=relaxed/simple;
	bh=dwYtLrPFUWzsdRZijCrgxVOKvCrrHbwJHagwewUlJLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYurYltlF1DsIkmrDrFOtO5N6+KjV8qlWNEdypdhZR/2nLSN3V4exRu1ut0t+WapGqhLTsAGsQY9Ta4If71qh2udH4RsezgKylLRyE9W5uvNJo0QtlobbmDc0yMuCnx65xqUNxonW1o4nwjQmcbYkSWfpOWaaMBjDKx/M+FsqBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/8K7XTe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/8K7XTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48290C4CEF7;
	Fri, 30 Jan 2026 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769787843;
	bh=dwYtLrPFUWzsdRZijCrgxVOKvCrrHbwJHagwewUlJLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/8K7XTeCjOi7IBVRmpSdHddjXnj/3yMYkeIFqKyCcafQt9NN+2/Ff9csk8aeWjZb
	 F1ugQinEx3A20mTBkl477lQbfdfWwuGmWNWDnbjy2dHAgHUVZAx1vQXtDrvEP5xoFm
	 vWqzqtNaYntqJg2dSBmJKCYkR3Pqj41ZpfanmiBtBywtXhUqqejFpE0wwguj/629zh
	 Fl6lqi3k6Cu4J0xxTc/PtRS1hMK//eqzlDKovlnjygZa2n88XdcdiioVgqPd0v+nLJ
	 4St7j9OJ8LjiCFVbQiy61l8IGLt2F9oRaGcDSVIwC1k2QA3+w+5rzgIxej87riM4h8
	 8fjyhOCr5xQxA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: lirongqing <lirongqing@baidu.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: remove __read_mostly from memory_idle_ms_percentiles
Date: Fri, 30 Jan 2026 07:43:48 -0800
Message-ID: <20260130154348.1094-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130153813.784-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One nit.  Let's use "mm/damon/stat:" for the subject prefix.  Andrew, could you
please make the change when you add this to mm-new?


Thanks,
SJ

[...]
