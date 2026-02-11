Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7151CFBA;
	Wed, 11 Feb 2026 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770785142; cv=none; b=spDp0C1Pz4/eMj3wUMXdCcPUT9QyJmncZtwF6slxzi4DH2d40buC1eZHJ6UB/wK7VKHLwMRw9snYNwaqXtTqGnIegWXmw4/pYQ2OIXY/9qiuYmQVkIZlPM8sxPBQGpdZBUyRBWUF7bNE52YzkYvvfKQbHk+D7gujAnVby8vZ1CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770785142; c=relaxed/simple;
	bh=E5hH+94BQyQzA+weVXnVfrJGvZPLtKrpyR0k8/5AQms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WG2E3NiNJreYK1Gn7iOtyepNr+QRiTAVS9qwuup4seD6ll9VdDNft1IWYLWM39S0S3Dc/swFFV/zUJOtaqI2vsBzews02HYlPUCQh7oBgR6dfAdRaceTeUBX035INX+cGVNAlq5hnXms57DsKD2IYjK2vlTKoS51qd7Y0l5DIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdFUGL+b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdFUGL+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4D3C4CEF7;
	Wed, 11 Feb 2026 04:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770785141;
	bh=E5hH+94BQyQzA+weVXnVfrJGvZPLtKrpyR0k8/5AQms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdFUGL+bB3yHHLYGp3uRMfz4GT7WL9dcbyIhwyKGHGPChZv0av4AfVdCHTTG37oz8
	 XAs9Rv3JJJF840+0yCqH9Xp/Nba+Dsr2ATMSpCX0WCAuXg2Z15JdA8HT947N0vmijk
	 7k7dDib1TEcpcKgoKLUsCPWVpjjZZmXNXBIxAMphwen+pH5L6C2ctaCXYO3S42v+DT
	 mDNYxbRUorkKD5mja4kEqAlEfnKgYcr6i+ds6O4ythHzcoPegrAlt9fOeyb1RkuZQW
	 8thUrMqc1oiypWWYtoZhDLeol0M+Q5QBL2mN1HCpHbTcwEnSnwnIquTTrmCUcSPJse
	 bRawS+CdFqTyA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Data Access-aware Transparent Hugepages
Date: Tue, 10 Feb 2026 20:45:33 -0800
Message-ID: <20260211044533.69515-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260211022845.68865-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forgot Cc-ing damon@ and linux-kernel@.  Adding those.  Sorry for noise.

On Tue, 10 Feb 2026 18:28:55 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> Transparent Huge Pages (THP) could be more efficient if those are used only for
> frequently accessed data.  DAMON is one of the ways for fidning such hot data,
> and hence there were interests in utilizing DAMON for access-aware THP.  A
> simple experiment leveraging MADV_[NO]HUGEPAGE based on DAMON-identifed hot and
> cold memory regions was conducted as a proof of the concept.  The experiment
> demonstrated [1] an 80% reduction in memory overhead while retaining 46% of THP
> performance gains.
> 
> Multiple discussions for further developing production level access-aware THP
> solutions have followed.  Most of the discussions were made in private, though
> Asier recently proposed yet another approach [2] on the mailing list.  As a
> result, we collected interesting challenges and ideas for the production level
> data access-aware THP.  Some of the ideas are not yet public, could be
> controversial, and missing important things that more eyeballs can find.  I
> want to discuss those in LSF/MM/BPF to get more ideas and make high level
> community alignments for next steps.
> 
> [1] https://assets.amazon.science/b7/2b/ce53222247739b174f2b54498d1a/daos-data-access-aware-operating-system.pdf
> [2] https://lore.kernel.org/20260202145650.1795854-1-gutierrez.asier@huawei-partners.com
> 
> 
> Thanks,
> SJ
> 

Sent using hkml (https://github.com/sjp38/hackermail)
