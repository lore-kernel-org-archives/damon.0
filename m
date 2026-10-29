Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263624;
	b=BBz6OOPApT0IPKUlbLUXhwELFcgIQtnQIFJO2txshpS0NrlLZFGmRJcd2mj27+F0HjSA
	 6gW5/QHmhvgM3wOB1bnNvubQN8Kx4FEXBzoOsNZvDSG/svbzNIo8V+U18mEPqUvwV3Rjl
	 a0AuuFhj4VhK+ajzZy7BIfbV/+OoVcPMuGrLi1d4m9cPBEm+rIET8T4hQOBIRv4jV7cF6
	 RNvXIQpqPUSMUvljYJ8IgbhCNofPdu0zTo+wQROnaEAYYZs1LZFDq/p3yOczEvKgFIyxm
	 o3U5EVaFCScSlgGFSFb9pO+ozJlLnUSwxrQpcFltxPBorzWjcNIgAK+fe9j8z2RLiAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263624;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tV78vZscfPoA14MCcmwzx0cgiGHJeJ22WYiDl91+U0U=;
	b=Nk+G8KK0xUBgLrbL5m0FqJH889shTXK8usEAqulxwqhEc2MBFBmktdBc/88NJtO/6VQS
	 lcuZ7FlnFuTPyk5IrwE4E6G2Yxunrbf3KJtRjR+N3Q1eaqhYngFUj4R/dWMdUFJC+wmbO
	 dzeByE+q7GmuGVrYJ+TFYHf/aBExznxs6YF7783WMecIwOS3ot80+PFFjCuObxaUkbRtW
	 qKeT1fQ+vW9w6pAS+bKqATJQP6umGYMn7CtHnbU9hxAhQXayXGAkC8qTFsJJYzJvnt6PT
	 rmrcB/3mQtm/pP8UFG4Y3alTFjLimD4Yo1/+ggjN0KCuWdjjfFbPHgE/MOrnx1YnNwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AF+PiUlU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAAC606A31C
	for <damon@lists.linux.dev>; Thu, 29 Oct 2026 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AF+PiUlU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E671F01825;
	Thu, 29 Oct 2026 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793263624;
	bh=tV78vZscfPoA14MCcmwzx0cgiGHJeJ22WYiDl91+U0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AF+PiUlU6hS/ibQZ1hcA30+ck8+cZih/C9GqdFcyQewizPcXA1FHN+C36h9QHfSK6
	 3mlA20HdI7Dey42oji/C65wmCn4R4k6XpFuqK4wb3SlwAoAL1poZ/y7jvkSC707fc5
	 uIeWoNbWQt6JT6FR8BuyglRO84Lap9sSw+98uA+/1C2eeqz3qaMCiFMc95Qv0L+LC0
	 xiZcAVrjDXn9cIHJafS6hY0vlKc4ADZ49/pSCy+7CvHbWcw3Ff3Q8aPQZ4DMiDf681
	 mQnmzxsUMfSA/AlpX5iWYkaTorBpFJiMwZula4ik/UsGpnu6k+M7WChVn630Yyqiek
	 1MFRCvVdFaK8Q==
Message-ID: <sashiko-outbox-188988@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/sysfs-kunit: fix leaked pid reference
 in add_targets test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiaolei Wang" <xiaoleiwangxiaolei@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261029075609.35661-1-xiaoleiwangxiaolei@gmail.com>
References: <20261029075609.35661-1-xiaoleiwangxiaolei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:47:03 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
>=20
> damon_sysfs_test_add_targets() creates its monitoring context with
> damon_new_ctx(), which leaves ctx->ops zero-initialized.  Since
> DAMON_OPS_VADDR is zero, damon_target_has_pid() returns true for the
> context, and damon_sysfs_add_targets() therefore calls
> damon_set_target_pid() for each target it adds.  That function grabs a
> reference to the target's struct pid via find_get_pid().
>=20
> The test then tears the context down with damon_destroy_ctx(), which
> releases such a reference from ctx->ops.cleanup_target().  For the vaddr
> operations set that callback is damon_va_cleanup_target(), and it is the
> only place where the reference is put.  The test never selects an
> operations set, though, so cleanup_target is NULL and both references --
> one for each of the two damon_sysfs_add_targets() calls -- are leaked on
> [ ... ]
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Signed-off-by: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029075609.3566=
1-1-xiaoleiwangxiaolei@gmail.com?part=3D1

