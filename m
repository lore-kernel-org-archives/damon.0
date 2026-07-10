Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA9346A08;
	Fri, 10 Jul 2026 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693147; cv=none; b=VoNOtmed5/zmO+ODy7efaUe4wGNntXcfiyVfIfSQjr2fK0J3OJSYdAIryG00rH68lVwLIxSyx7DYb/kT/oV/s7e/uZdxjd/mIoJKfRC227Frq+7Z0Ev2y7ODqWDobOuR+DcGaqYFetjLkNWgZCGrDVzo4lUnEzIO2av6C/zDsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693147; c=relaxed/simple;
	bh=NOYvfkSM9ca1CqaAcC0JpA3gF5+Y/2UdSzbdKhkKiLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Owu3/F0QrtP2K2fBDaXWzD1soqimmP2Ebe5yuJjV3OgUTemyQK/gRK0pDFJMzJ01j4wc16rMbpBOmqc+KAcf61JBstBjDEoT3mVPBaWKJFdNAfaxL0wL5P8XEORiF79RlNr/tL04AD14mlE0Af4ynpnVImGnjH0HfClHu/aZBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd++3JU6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd++3JU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D251F00A3A;
	Fri, 10 Jul 2026 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783693146;
	bh=dlb3WD7/szOCNyvIUD9XAK0jmIyFraoZyD8UZq/GPXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bd++3JU6myGmdIMMne53urwP13UFJCmJ7dBhnvgWv5Fmtz9ryc7S9KMuyqEPbopMO
	 Cf6kscvoweWO7QVGoOPMYEENlT8EpH/UnguxrAs4oAe9RqqQLww4YlFOxnn6O9Imtw
	 G5YBpI9tulEdjpz74VJy1oLMZzscuRFxLyAeyReVl9eeqFcyB3rBxL6fF1W72sFJ3L
	 pQfRHmK/n9/ByfYsUzGSuaMEj2V0jsD9u3Uw1l5nMud/dgZnCp/rMxFpI5qhm9qHfT
	 AQ14cl4meMv4mfxaMftZxRxzqpUulZ+gA+ID7ejErCHPOvWnBoNrh4lJhhzPECEt/Z
	 A0XYgiRNFpTcg==
From: SJ Park <sj@kernel.org>
To: Song Hu <husong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/4] Docs/ABI/damon: fix typos
Date: Fri, 10 Jul 2026 07:18:58 -0700
Message-ID: <20260710141859.24919-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710044737.561102-3-husong@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 12:47:35 +0800 Song Hu <husong@kylinos.cn> wrote:

> Fix two typos in the DAMON sysfs ABI document:
> 
>   - "WDate:" -> "Date:" on the nr_regions/min entry
>   - "manimum" -> "minimum" in the nr_accesses/min description

Good eyes!

> 
> Signed-off-by: Song Hu <husong@kylinos.cn>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
