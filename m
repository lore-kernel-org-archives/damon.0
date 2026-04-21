Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C74367F32
	for <damon@lists.linux.dev>; Tue, 21 Apr 2026 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755198; cv=none; b=BF9BDiLposZIPkIF66HsQCGPJZkm7U+JfaW/btsAfP3JHVk8IgfY4jUwCnFt1gl8ae99HzKlxCqt3liT1ntQQFsRrGSGHxgrx7icA9gkxw/Zk8+XQnlbk9UnQJ/3qbnhWU8usXvUBE8L90T3++N9M68BVMY/j8Ma1CsOjDh7WEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755198; c=relaxed/simple;
	bh=AHAhOsAsCo1OfYix6dK1OkxOFwv40/ULWmkGxTJ6iJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2gS7Xl81iXnifAbcP9XvtvhhslDWqx8edVFItWb+mXt0SVkLJ2SiBAxUeRSStHJSaY1yKOTXvAMjC866WQ+G0DcnUJktkKn3FzpEARXDW3nXvWLdeUjyEJRJ1TD2d/yA9XN8h4ix5oXTV79+vmTEMKePno7XZipNYngW2SC1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpN9lrYt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpN9lrYt"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f33d28c1dso2126353b3a.3
        for <damon@lists.linux.dev>; Tue, 21 Apr 2026 00:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776755196; x=1777359996; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3/fDMvwGHTrdxJihlczjMCWxYDe7v2g1QVzypmLroA=;
        b=LpN9lrYtqjJFt70VedqrDIfgIBg3Y30y0uKYpSqylRGcY4ekruOgr1gWZb9qfpu+Pj
         5SYC2jwmL76X7/Wtg2Su2r3jPXlWQHZB4lPjDp7ZBUjOgXJPAwNvP11tNomYFjnRE1m9
         VStj0azNUNO4O2ZVPwl9M7pBNdXUIXAvLQ+mDFbdP/sWJ1cvuK/vsY1RtzBHYauYsWWQ
         FHfWMV3MOAtBZUjEhzRKk9W+c9K10AteahHU7TV3+LsUsXrgOOzWYh8dMOdcFZrgpd90
         81HF9wHjC9abzK4CBGJCXp3ebDYeU6T+RSOa4ot0pm2r80DYeGOgSeUB0vwOurL2q7AS
         GORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776755196; x=1777359996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N3/fDMvwGHTrdxJihlczjMCWxYDe7v2g1QVzypmLroA=;
        b=kc522r+PzQQRCHbgf85s4JZZjYw3X9XqUvWNCvEeZ07jrw8yyF1Osu5llZvf6IlhL/
         gw+LxLEX5EoDnB01T1tAC+vkA8i0K1/qf+cPUtrtf2agjr+PLAJ2bmgq2nTMrw2b/rFI
         ZqhHzutaycDX8tIe5pzbylYlcrUaPBhFB2wCccoN8pL59HS4ZoqH3dtfV7Hu3J/cPHu3
         xsOFd+qLqXq3luqqyth8vG/fwJ7FT+43whHlZeg81Izfrti1R+tS6rJXVlhTfjvPpsbB
         zghTHxe2zcRoiGEdBAjE4hhsVY0iexyi7g04h3z4OKTmD7xMSr9GBfsjzSK10FJFYVHG
         FH9w==
X-Forwarded-Encrypted: i=1; AFNElJ+vSgiL6KYKUBd1LcfpwhTBUvo+Bmr6DN7XPLGe+0UOqEPDx2M2ziX6QZdQeqvxPvkqb13JDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVLjJeP1Eqmkf2LBgStIXaMfD+dsxMUBNMU6Qb1XzHSYm3UgzP
	Aoq3EOXVJybLkbuF9Y5lB5N6kkwACW0Nczc3592Rf7vpE1X4XHtT/VX+
X-Gm-Gg: AeBDieunJTUwkociALpvp8r//mH91AmVKs0EvqRp0QwnCX/XXpj32YM8tTONN+Ezl7/
	+BeoW+aqHGNoICLxyJ9ihf8zEQ3Ubv+hv4KmhvGQffVNz7YBJD898CGrQkGQ372lDBnqvwwFDMU
	mA1c2RFabdQRAC8yqHb3yaTZuA+ml7me9hAcPq36xUvCilfnltYIk1PTvv2uCW6fJjRAQsU/3yt
	H2P01Nvm4AkMI8JLdGsnxKmBCXhIVpJhVA8vSSt+MEKIi6iuijHT1bMkzEc7K65yL31SKQJ4JKH
	7jYkU1Lmvmmlb95zqnPAaLIqRsqynnxRzoQbw5UOg9OBvZ+onvX3ApLCt3HT1N1ttXKLZLIjywl
	0ZYc4rMXdz9yGi80Dp5hud6pwmi2v2KSxKsHl5W6U6bdChaC7TjjU9wMk7ozzKFbPtodf/q0vTl
	ZHtExucwDUMH6lZw60sdwFmmeQPlemngPwj9ecDGLqD6Q=
X-Received: by 2002:a05:6a00:4408:b0:82c:6b1b:7ad4 with SMTP id d2e1a72fcca58-82f8c84d3aamr17049309b3a.3.1776755195927;
        Tue, 21 Apr 2026 00:06:35 -0700 (PDT)
Received: from localhost.tail66efb9.ts.net ([240e:3b5:d06b:eea0::1000])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9819fesm12869383b3a.4.2026.04.21.00.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 00:06:35 -0700 (PDT)
From: Junxi Qian <qjx1298677004@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: fix use-after-free on memcg_path and goal path
Date: Tue, 21 Apr 2026 15:06:32 +0800
Message-Id: <20260421070632.161808-1-qjx1298677004@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420085332.178473-1-qjx1298677004@gmail.com>
References: <20260420085332.178473-1-qjx1298677004@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi SJ,

Thanks for the suggestion.

I checked the show/store race further and was able to reproduce the
memcg_path_show() side issue on a KASAN kernel.

#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <signal.h>
#include <stdatomic.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#define DAMON_BASE "/sys/kernel/mm/damon/admin"
#define MAX_PATH 1024
#define MAX_BUF  4096

static atomic_int stop_flag;

struct worker_arg {
	const char *path;
	int tid;
	unsigned long long ops;
	unsigned int seed;
};

static void on_signal(int sig)
{
	(void)sig;
	atomic_store(&stop_flag, 1);
}

static int write_buf(const char *path, const char *buf, size_t len)
{
	int fd;
	ssize_t written;
	int saved_errno;

	fd = open(path, O_WRONLY | O_CLOEXEC);
	if (fd < 0)
		return -errno;

	written = write(fd, buf, len);
	saved_errno = errno;
	close(fd);

	if (written < 0)
		return -saved_errno;
	if ((size_t)written != len)
		return -EIO;
	return 0;
}

static int write_str(const char *path, const char *val)
{
	return write_buf(path, val, strlen(val));
}

static int read_once(const char *path, char *buf, size_t buf_sz)
{
	int fd;
	ssize_t n;
	int saved_errno;

	fd = open(path, O_RDONLY | O_CLOEXEC);
	if (fd < 0)
		return -errno;

	n = read(fd, buf, buf_sz - 1);
	saved_errno = errno;
	close(fd);

	if (n < 0)
		return -saved_errno;
	buf[n] = '\0';
	return 0;
}

static size_t make_payload(char *buf, size_t buf_sz, unsigned int *seed,
		int tid, unsigned long long iter)
{
	static const size_t interesting_lengths[] = {
		1, 2, 3, 4, 7, 8, 15, 16, 31, 32, 63, 64,
		127, 128, 255, 256, 511, 512, 1023, 1024,
		1535, 2047, 2048, 3071, 3583, 4095,
	};
	const char alphabet[] =
		"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/_-.";
	size_t len;
	size_t i;
	unsigned int idx;

	idx = rand_r(seed) % (sizeof(interesting_lengths) / sizeof(interesting_lengths[0]));
	len = interesting_lengths[idx];
	if (len >= buf_sz)
		len = buf_sz - 1;

	for (i = 0; i < len; i++)
		buf[i] = alphabet[rand_r(seed) % (sizeof(alphabet) - 1)];

	if (len > 20)
		snprintf(buf, len, "/damon_race/%d/%llu/", tid, iter);

	buf[len] = '\0';
	return len;
}

static void *reader_thread(void *data)
{
	struct worker_arg *arg = data;
	char buf[MAX_BUF + 1];

	while (!atomic_load(&stop_flag)) {
		int err = read_once(arg->path, buf, sizeof(buf));

		if (err && err != -EBUSY) {
			fprintf(stderr, "reader[%d] %s failed: %s\n",
				arg->tid, arg->path, strerror(-err));
			atomic_store(&stop_flag, 1);
			break;
		}
		arg->ops++;
	}
	return NULL;
}

static void *writer_thread(void *data)
{
	struct worker_arg *arg = data;
	char buf[MAX_BUF + 1];
	unsigned long long iter = 0;

	while (!atomic_load(&stop_flag)) {
		size_t len = make_payload(buf, sizeof(buf), &arg->seed, arg->tid, iter++);
		int err = write_buf(arg->path, buf, len);

		if (err && err != -EBUSY) {
			fprintf(stderr, "writer[%d] %s failed: %s\n",
				arg->tid, arg->path, strerror(-err));
			atomic_store(&stop_flag, 1);
			break;
		}
		arg->ops++;
	}
	return NULL;
}

static int ensure_damon_layout(char *memcg_path_file, size_t memcg_sz,
		char *goal_path_file, size_t goal_sz)
{
	char path[MAX_PATH];
	int err;

	snprintf(path, sizeof(path), "%s/kdamonds/nr_kdamonds", DAMON_BASE);
	if ((err = write_str(path, "1")))
		return err;

	snprintf(path, sizeof(path), "%s/kdamonds/0/contexts/nr_contexts", DAMON_BASE);
	if ((err = write_str(path, "1")))
		return err;

	snprintf(path, sizeof(path), "%s/kdamonds/0/contexts/0/schemes/nr_schemes", DAMON_BASE);
	if ((err = write_str(path, "1")))
		return err;

	snprintf(path, sizeof(path), "%s/kdamonds/0/contexts/0/schemes/0/action", DAMON_BASE);
	if ((err = write_str(path, "stat")))
		return err;

	snprintf(path, sizeof(path),
		 "%s/kdamonds/0/contexts/0/schemes/0/filters/nr_filters", DAMON_BASE);
	if ((err = write_str(path, "1")))
		return err;

	snprintf(path, sizeof(path),
		 "%s/kdamonds/0/contexts/0/schemes/0/filters/0/type", DAMON_BASE);
	if ((err = write_str(path, "memcg")))
		return err;

	snprintf(memcg_path_file, memcg_sz,
		 "%s/kdamonds/0/contexts/0/schemes/0/filters/0/memcg_path", DAMON_BASE);
	if ((err = write_str(memcg_path_file, "/")))
		return err;

	snprintf(path, sizeof(path),
		 "%s/kdamonds/0/contexts/0/schemes/0/quotas/goals/nr_goals", DAMON_BASE);
	if ((err = write_str(path, "1")))
		return err;

	snprintf(path, sizeof(path),
		 "%s/kdamonds/0/contexts/0/schemes/0/quotas/goals/0/target_metric", DAMON_BASE);
	if ((err = write_str(path, "node_memcg_used_bp")))
		return err;

	snprintf(path, sizeof(path),
		 "%s/kdamonds/0/contexts/0/schemes/0/quotas/goals/0/target_value", DAMON_BASE);
	if ((err = write_str(path, "1")))
		return err;

	snprintf(path, sizeof(path),
		 "%s/kdamonds/0/contexts/0/schemes/0/quotas/goals/0/nid", DAMON_BASE);
	if ((err = write_str(path, "0")))
		return err;

	snprintf(goal_path_file, goal_sz,
		 "%s/kdamonds/0/contexts/0/schemes/0/quotas/goals/0/path", DAMON_BASE);
	if ((err = write_str(goal_path_file, "/")))
		return err;

	return 0;
}

static int cleanup_damon_layout(void)
{
	char path[MAX_PATH];

	snprintf(path, sizeof(path), "%s/kdamonds/nr_kdamonds", DAMON_BASE);
	return write_str(path, "0");
}

static int run_stress(const char *name, const char *path,
		int seconds, int nr_readers, int nr_writers)
{
	pthread_t *threads;
	struct worker_arg *args;
	int total_threads = nr_readers + nr_writers;
	int i;
	int err;
	unsigned long long total_reads = 0;
	unsigned long long total_writes = 0;

	threads = calloc(total_threads, sizeof(*threads));
	args = calloc(total_threads, sizeof(*args));
	if (!threads || !args) {
		free(threads);
		free(args);
		return -ENOMEM;
	}

	atomic_store(&stop_flag, 0);
	printf("[*] stressing %s: %s (%d readers, %d writers, %d sec)\n",
		name, path, nr_readers, nr_writers, seconds);
	fflush(stdout);

	for (i = 0; i < total_threads; i++) {
		args[i].path = path;
		args[i].tid = i;
		args[i].seed = (unsigned int)time(NULL) ^ (i * 0x9e3779b9U);
		if (i < nr_readers)
			err = pthread_create(&threads[i], NULL, reader_thread, &args[i]);
		else
			err = pthread_create(&threads[i], NULL, writer_thread, &args[i]);
		if (err) {
			fprintf(stderr, "pthread_create failed: %s\n", strerror(err));
			atomic_store(&stop_flag, 1);
			total_threads = i;
			break;
		}
	}

	for (i = 0; i < seconds && !atomic_load(&stop_flag); i++)
		sleep(1);
	atomic_store(&stop_flag, 1);

	for (i = 0; i < total_threads; i++)
		pthread_join(threads[i], NULL);

	for (i = 0; i < nr_readers && i < total_threads; i++)
		total_reads += args[i].ops;
	for (; i < total_threads; i++)
		total_writes += args[i].ops;

	printf("[*] %s done: reads=%llu writes=%llu\n",
		name, total_reads, total_writes);
	free(threads);
	free(args);
	return 0;
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"Usage: %s [memcg|goal|both] [seconds] [readers] [writers]\n"
		"  default mode: both\n"
		"  default seconds/readers/writers: 60 8 8\n",
		prog);
}

int main(int argc, char **argv)
{
	char memcg_path_file[MAX_PATH];
	char goal_path_file[MAX_PATH];
	const char *mode = "both";
	int seconds = 60;
	int readers = 8;
	int writers = 8;
	int err;
	bool test_memcg = true;
	bool test_goal = true;

	if (argc > 1)
		mode = argv[1];
	if (argc > 2)
		seconds = atoi(argv[2]);
	if (argc > 3)
		readers = atoi(argv[3]);
	if (argc > 4)
		writers = atoi(argv[4]);
	if (seconds <= 0 || readers <= 0 || writers <= 0) {
		usage(argv[0]);
		return 1;
	}

	if (!strcmp(mode, "memcg"))
		test_goal = false;
	else if (!strcmp(mode, "goal"))
		test_memcg = false;
	else if (strcmp(mode, "both")) {
		usage(argv[0]);
		return 1;
	}

	if (geteuid() != 0) {
		fprintf(stderr, "Need root\n");
		return 1;
	}

	signal(SIGINT, on_signal);
	signal(SIGTERM, on_signal);

	err = ensure_damon_layout(memcg_path_file, sizeof(memcg_path_file),
			goal_path_file, sizeof(goal_path_file));
	if (err) {
		fprintf(stderr, "DAMON setup failed: %s\n", strerror(-err));
		return 1;
	}

	printf("[*] memcg_path file: %s\n", memcg_path_file);
	printf("[*] goal path file : %s\n", goal_path_file);
	printf("[*] each access opens the sysfs file anew to avoid reusing the same kernfs_open_file mutex\n");
	printf("[*] watch dmesg for KASAN splats while this runs\n");
	fflush(stdout);

	if (test_memcg) {
		err = run_stress("memcg_path show/store race", memcg_path_file,
				seconds, readers, writers);
		if (err)
			goto out;
	}
	if (test_goal) {
		err = run_stress("quota goal path show/store race", goal_path_file,
				seconds, readers, writers);
		if (err)
			goto out;
	}

out:
	if (cleanup_damon_layout())
		fprintf(stderr, "warning: failed to cleanup DAMON sysfs layout\n");
	if (err)
		return 1;

	printf("[*] done. Check: dmesg | grep -A20 -E 'BUG: KASAN|use-after-free'\n");
	return 0;
}

And below is the full KASAN report I got.

[*] memcg_path file: /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/0/filters/0/memcg_path
[*] goal path file : /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/0/quotas/goals/0/path
[*] each access opens the sysfs file anew to avoid reusing the same kernfs_open_file mutex
[*] watch dmesg for KASAN splats while this runs
[*] stressing memcg_path show/store race: /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/0/filters/0/memcg_path (8 readers, 8 writers, 60 sec)
[    4.038673] ==================================================================
[    4.040040] BUG: KASAN: slab-use-after-free in string+0x396/0x440
[    4.041106] Read of size 1 at addr ffff888100be9120 by task exp/155
[    4.042288]
[    4.042617] CPU: 1 UID: 0 PID: 155 Comm: exp Not tainted 7.0.0-rc5-gd38efd7c139a #18 PREEMPT(lazy)
[    4.042621] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    4.042622] Call Trace:
[    4.042624]  <TASK>
[    4.042625]  dump_stack_lvl+0x55/0x70
[    4.042629]  print_report+0xcb/0x5d0
[    4.042633]  ? string+0x396/0x440
[    4.042635]  kasan_report+0xb8/0xf0
[    4.042637]  ? string+0x396/0x440
[    4.042640]  string+0x396/0x440
[    4.042642]  ? __pfx_string+0x10/0x10
[    4.042644]  ? kasan_save_stack+0x24/0x50
[    4.042646]  ? __kvmalloc_node_noprof+0x1cf/0x660
[    4.042648]  ? seq_read_iter+0x67c/0x1050
[    4.042652]  ? vfs_read+0x657/0x910
[    4.042654]  ? ksys_read+0xee/0x1c0
[    4.042656]  ? do_syscall_64+0xfc/0x580
[    4.042658]  vsnprintf+0x435/0x1270
[    4.042661]  ? stack_trace_save+0x8e/0xc0
[    4.042664]  ? __pfx_vsnprintf+0x10/0x10
[    4.042667]  ? do_sys_openat2+0xe5/0x170
[    4.042668]  ? kasan_save_stack+0x34/0x50
[    4.042670]  ? kasan_save_stack+0x24/0x50
[    4.042671]  ? kasan_save_track+0x17/0x60
[    4.042673]  ? __pfx_kobj_attr_show+0x10/0x10
[    4.042676]  vscnprintf+0x12/0x30
[    4.042678]  sysfs_emit+0xbe/0x110
[    4.042681]  ? __pfx_sysfs_emit+0x10/0x10
[    4.042683]  memcg_path_show+0x48/0x60
[    4.042685]  sysfs_kf_seq_show+0x2a0/0x4a0
[    4.042687]  seq_read_iter+0x402/0x1050
[    4.042690]  ? kvm_sched_clock_read+0x11/0x20
[    4.042692]  vfs_read+0x657/0x910
[    4.042694]  ? do_sys_openat2+0xe5/0x170
[    4.042696]  ? kmem_cache_free+0xb5/0x3c0
[    4.042698]  ? __pfx_vfs_read+0x10/0x10
[    4.042700]  ? __pfx_mutex_lock+0x10/0x10
[    4.042703]  ? fdget_pos+0x249/0x4c0
[    4.042706]  ksys_read+0xee/0x1c0
[    4.042708]  ? __pfx_ksys_read+0x10/0x10
[    4.042710]  do_syscall_64+0xfc/0x580
[    4.042712]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    4.042714] RIP: 0033:0x44c89c
[    4.042716] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 49 ab 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff8
[    4.042718] RSP: 002b:00007f779d33e170 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[    4.042721] RAX: ffffffffffffffda RBX: 00007f779d33f5f0 RCX: 000000000044c89c
[    4.042723] RDX: 0000000000001000 RSI: 00007f779d33e1a0 RDI: 000000000000000b
[    4.042724] RBP: 000000000000000b R08: 0000000000000000 R09: 00007ffe9b7899df
[    4.042725] R10: 0000000000000000 R11: 0000000000000246 R12: 000000002ef138d0
[    4.042726] R13: 00007f779d33e1a0 R14: 0000000000000002 R15: 00007f779cb3f000
[    4.042728]  </TASK>
[    4.042729]
[    4.089403] Allocated by task 158 on cpu 0 at 4.038654s:
[    4.090348]  kasan_save_stack+0x24/0x50
[    4.091058]  kasan_save_track+0x17/0x60
[    4.091780]  __kasan_kmalloc+0x7f/0x90
[    4.092508]  __kmalloc_noprof+0x191/0x490
[    4.093275]  memcg_path_store+0x32/0xc0
[    4.094000]  kernfs_fop_write_iter+0x2fc/0x490
[    4.094825]  vfs_write+0x8e1/0xcc0
[    4.095465]  ksys_write+0xee/0x1c0
[    4.096132]  do_syscall_64+0xfc/0x580
[    4.096758]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    4.097648]
[    4.097957] Freed by task 158 on cpu 0 at 4.038671s:
[    4.098985]  kasan_save_stack+0x24/0x50
[    4.099767]  kasan_save_track+0x17/0x60
[    4.100615]  kasan_save_free_info+0x3b/0x60
[    4.101478]  __kasan_slab_free+0x43/0x70
[    4.102193]  kfree+0x137/0x3b0
[    4.102797]  memcg_path_store+0x6e/0xc0
[    4.103577]  kernfs_fop_write_iter+0x2fc/0x490
[    4.104382]  vfs_write+0x8e1/0xcc0
[    4.104993]  ksys_write+0xee/0x1c0
[    4.105662]  do_syscall_64+0xfc/0x580
[    4.106328]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    4.107217]
[    4.107533] The buggy address belongs to the object at ffff888100be9120
[    4.107533]  which belongs to the cache kmalloc-8 of size 8
[    4.109626] The buggy address is located 0 bytes inside of
[    4.109626]  freed 8-byte region [ffff888100be9120, ffff888100be9128)
[    4.111972]
[    4.112332] The buggy address belongs to the physical page:
[    4.113259] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888100be9630 pfn:0x100be9
[    4.114944] flags: 0x200000000000200(workingset|node=0|zone=2)
[    4.116300] page_type: f5(slab)
[    4.116909] raw: 0200000000000200 ffff888100041500 ffffea000402f550 ffffea000401ae50
[    4.118974] raw: ffff888100be9630 000000000055003f 00000000f5000000 0000000000000000
[    4.120293] page dumped because: kasan: bad access detected
[    4.121299]
[    4.121633] Memory state around the buggy address:
[    4.122571]  ffff888100be9000: fa fc fc fc fc fc fa fc fc fc fc fc fa fc fc fc
[    4.123920]  ffff888100be9080: fc fc fa fc fc fc fc fc fa fc fc fc fc fc fa fc
[    4.125299] >ffff888100be9100: fc fc fc fc fa fc fc fc fc fc fa fc fc fc fc fc
[    4.126615]                                ^
[    4.127380]  ffff888100be9180: 02 fc fc fc fc fc fa fc fc fc fc fc fa fc fc fc
[    4.128760]  ffff888100be9200: fc fc fa fc fc fc fc fc 02 fc fc fc fc fc 02 fc
[    4.130067] ==================================================================
[    4.389108] Disabling lock debugging due to kernel taint
[    7.139036] BUG: kernel NULL pointer dereference, address: 0000000000000008
[    7.141323] #PF: supervisor read access in kernel mode
[    7.142210] #PF: error_code(0x0000) - not-present page
[    7.143341] PGD 7c46067 P4D 7c46067 PUD 7c3a067 PMD 0
[    7.144498] Oops: Oops: 0000 [#1] SMP KASAN NOPTI
[    7.145386] CPU: 0 UID: 0 PID: 154 Comm: exp Tainted: G    B               7.0.0-rc5-gd38efd7c139a #18 PREEMPT(lazy)
[    7.148291] Tainted: [B]=BAD_PAGE
[    7.148983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    7.150355] RIP: 0010:qlist_free_all+0xab/0x130
[    7.150954] Code: 01 ca 48 c1 ea 0c 48 c1 e2 06 48 03 15 de 30 e4 03 48 8b 4a 08 48 8d 71 ff 83 e1 01 48 0f 45 d6 31 c9 80 7a 33 f5 48 0f 45 d1 <48> 8b 6a 08 e9 6a0
[    7.153069] RSP: 0018:ffff888011e1fbb8 EFLAGS: 00010206
[    7.153667] RAX: ffff88800f6bc000 RBX: ffff88800f6bc000 RCX: 0000000000000000
[    7.154543] RDX: 0000000000000000 RSI: ffffffffffffffff RDI: ffff888100042000
[    7.155362] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8198f0eb
[    7.156454] R10: ffff88800e245000 R11: 0000000000000246 R12: 0000000000000000
[    7.157576] R13: ffff888011e1fbf0 R14: ffff88800e245000 R15: ffff88800e245000
[    7.158648] FS:  00007f779db40640(0000) GS:ffff88817bc47000(0000) knlGS:0000000000000000
[    7.160170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.160930] CR2: 0000000000000008 CR3: 0000000008ba3002 CR4: 0000000000370ef0
[    7.161911] Call Trace:
[    7.162685]  <TASK>
[    7.163117]  kasan_quarantine_reduce+0x15d/0x180
[    7.163636]  __kasan_slab_alloc+0x49/0x70
[    7.164079]  __kvmalloc_node_noprof+0x18f/0x660
[    7.164644]  ? seq_read_iter+0x67c/0x1050
[    7.165322]  seq_read_iter+0x67c/0x1050
[    7.165967]  ? kvm_sched_clock_read+0x11/0x20
[    7.166692]  ? kvm_sched_clock_read+0x11/0x20
[    7.167660]  vfs_read+0x657/0x910
[    7.168365]  ? do_sys_openat2+0xe5/0x170
[    7.169243]  ? kmem_cache_free+0xb5/0x3c0
[    7.169789]  ? __pfx_vfs_read+0x10/0x10
[    7.170466]  ? __pfx_mutex_lock+0x10/0x10
[    7.171028]  ? fdget_pos+0x249/0x4c0
[    7.171474]  ksys_read+0xee/0x1c0
[    7.171971]  ? __pfx_ksys_read+0x10/0x10
[    7.172545]  do_syscall_64+0xfc/0x580
[    7.173106]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    7.173879] RIP: 0033:0x44c89c
[    7.174343] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 49 ab 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff8
[    7.176964] RSP: 002b:00007f779db3f170 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[    7.178045] RAX: ffffffffffffffda RBX: 00007f779db405f0 RCX: 000000000044c89c
[    7.179145] RDX: 0000000000001000 RSI: 00007f779db3f1a0 RDI: 0000000000000005
[    7.180449] RBP: 0000000000000005 R08: 0000000000000000 R09: 00007ffe9b7899df
[    7.181732] R10: 0000000000000000 R11: 0000000000000246 R12: 000000002ef138b0
[    7.183041] R13: 00007f779db3f1a0 R14: 0000000000000016 R15: 00007f779d340000
[    7.184602]  </TASK>
[    7.185159] Modules linked in:
[    7.185828] CR2: 0000000000000008
[    7.186582] ---[ end trace 0000000000000000 ]---
[    7.187296] RIP: 0010:qlist_free_all+0xab/0x130
[    7.187837] Code: 01 ca 48 c1 ea 0c 48 c1 e2 06 48 03 15 de 30 e4 03 48 8b 4a 08 48 8d 71 ff 83 e1 01 48 0f 45 d6 31 c9 80 7a 33 f5 48 0f 45 d1 <48> 8b 6a 08 e9 6a0
[    7.190065] RSP: 0018:ffff888011e1fbb8 EFLAGS: 00010206
[    7.190674] RAX: ffff88800f6bc000 RBX: ffff88800f6bc000 RCX: 0000000000000000
[    7.191649] RDX: 0000000000000000 RSI: ffffffffffffffff RDI: ffff888100042000
[    7.192504] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8198f0eb
[    7.193436] R10: ffff88800e245000 R11: 0000000000000246 R12: 0000000000000000
[    7.194506] R13: ffff888011e1fbf0 R14: ffff88800e245000 R15: ffff88800e245000
[    7.195513] FS:  00007f779db40640(0000) GS:ffff88817bc47000(0000) knlGS:0000000000000000
[    7.196530] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.197420] CR2: 0000000000000008 CR3: 0000000008ba3002 CR4: 0000000000370ef0
[    7.198744] note: exp[154] exited with irqs disabled

I will spend some time thinking about how to fix this properly.

If someone more familiar with this code would like to work on the fix
directly, that would be greatly appreciated, as I am not very familiar
with this part of the code yet.

Thanks,
Junxi
