Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D02AF00;
	Sun, 16 Aug 2026 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786899400; cv=none; b=FlWIPb3v1DQ17S6rAcz7dOw7VecBJXb+zdagpo0goUuDMwT+83tLZ/bWHxjVc9IlBO5vGvA/nVxUjcCUD1yCV7sASmOtyb4852e5/M5/UZV6bIGf77gvYXKlV90XhLBTY9c8IkjJwACVyQMG9LA08s0kjdckY2kjQs+Vi4pEHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786899400; c=relaxed/simple;
	bh=HlDOxnHuMMVHohuVwHAfqMLOmi81A8VTk4PlceL9JLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk5HrQTc0KKvnuNpngiH5YIOKbW8G0iPsbhyH59IzkpXm65F3L6E+u3d/y3075dtZJNu6x8jL+6pZx49HeBgi8rqA2kGgVoaVVAat41LfpRyrnqte1nuT1F+LsIIQLNjUm9MEJG7fDfsyaIVchW46a3hgBdsbHGN8bU8SzwfHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoTWVWmF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoTWVWmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2391F000E9;
	Sun, 16 Aug 2026 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786899399;
	bh=E22bAb27mfMqnbRiG04AZdJeCfsHv2IcYh0cVnbi8Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MoTWVWmF1j3YIqeKXe6Zcl3S0IhuZuEXW4jICpFS155i0lG9Qduxj7ysRpwX9Rgoa
	 ED7J//lF0Bnks4pHOgZHXMMwA5nvtc2VY5nxlyHyT3QklK20SQAQTJuLmaZZaFsNBr
	 aFrIdXvX/J8uhi3M6tdpTAqhNH4D+J5vLvfng/llZ69dSBB5V6OdohPrhwnc8jYF3i
	 g4Zt4UEY3jah8KoVVRCUFF7NFE8BxjyNyHDgpodZcBjbgORLHg1iutERtC9A6sElQr
	 AACpNqLU/y15qDx76bzdFvhg8CMvrYlKKZuTj0LsSE274QrxQzlEKKIyWufwrXs62J
	 zoUQ/yrdU7xTg==
From: SJ Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	will@kernel.org,
	mark.rutland@arm.com,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	kunwu.chan@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] mm/damon/perf: add ARM SPE AUX backend
Date: Sun, 16 Aug 2026 09:56:30 -0700
Message-ID: <20260816165630.84808-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816142222.689624-1-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Kunwu,

On Sun, 16 Aug 2026 22:22:17 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:

> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> This series adds an AUX trace-buffer backend to the DAMON perf
> observability framework, enabling ARM SPE (Statistical Profiling
> Extension) to deliver hardware-sampled access reports into DAMON's
> existing SPSC report ring.

Awesome.  Thank you for making this.  This will make DAMON be more useful on
ARM machines.

> 
> Patch 2 touches drivers/perf/arm_spe_pmu.c to expose the PMU matcher.
> This change is tightly coupled with the DAMON AUX backend.  ARM SPE
> PMU driver maintainers only need to review patch 2.
> 
> This series is based on the Ravi's hardware-sampled access reports 
> branch [1], and depends on the perf AUX kernel-consumer RFC series [2].
> The dependencies is not upstream yet, so this series remains RFC.

Unfortunately I haven't had a time to thoroughly read the dependent patches.  I
believe the basic idea of this patch series is aligned with the ongoing DAMON
extension roadmap [1], though.  That is, this series is supposed to be a part
of the milestone 3.  We are currently at the near end of milestone 1, and aim
to complete milestone 2 by the time around next year's LSFMMBPF.

I will hold review of this series for now, and take more time on making
milestones 1 and 2 for thier planned delivery timeline.  Sorry for being a
bottleneck of your work, and thanks in advance for your patience.

Please feel free to let me know if you have specific parts that need my review
right now, though.  Otherwise, please make sure this is aligned with the
roadmap until we finish the milestone 2.  I do want ARM SPE support of DAMON.

[1] https://lore.kernel.org/all/20260525225208.1179-1-sj@kernel.org/


Thanks,
SJ

[...]
